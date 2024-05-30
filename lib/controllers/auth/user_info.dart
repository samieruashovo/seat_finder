import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:seat_finder/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetUserInfo {
  Future<String?> refreshAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? refreshToken = prefs.getString('refresh');

    if (refreshToken == null) {
      // Handle missing refresh token
      return null;
    }

    final response = await http.post(
      Uri.parse(ApiEndPoints.baseUrl + '/auth/jwt/refresh/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'refresh': refreshToken}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final String? newAccessToken = responseData['access'];

      if (newAccessToken != null) {
        await prefs.setString('access', newAccessToken);
        return newAccessToken;
      }
    }

    // Handle error
    return null;
  }

  Future<Map<String, dynamic>?> getUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access');

    // If access token is not available, refresh it
    if (accessToken == null) {
      accessToken = await refreshAccessToken();
    }

    if (accessToken == null) {
      // Handle missing access token
      return null;
    }

    final response = await http.get(
      Uri.parse('http://yourapiurl/auth/users/me/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      // Token might have expired, try refreshing it
      accessToken = await refreshAccessToken();

      if (accessToken != null) {
        final retryResponse = await http.get(
          Uri.parse('http://yourapiurl/auth/users/me/'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
        );

        if (retryResponse.statusCode == 200) {
          return json.decode(retryResponse.body);
        }
      }
    }

    // Handle error
    return null;
  }

  void retrieveUserInfo() async {
    final userInfo = await getUserInfo();
    if (userInfo != null) {
      // Handle the retrieved user information
      print('User Info: $userInfo');
    } else {
      // Handle error
      print('Failed to retrieve user info');
    }
  }
}

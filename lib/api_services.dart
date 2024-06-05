import 'package:seat_finder/api_endpoints.dart';

import 'models/events.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServices {
  Future<List<Event>> fetchEvents() async {
    // print("running fe");
    final response =
        await http.get(Uri.parse('${ApiEndPoints.baseUrl}api/events/'));
    // print(response.statusCode.toString() + ' status code');
    if (response.statusCode == 200) {
      // print("code 200");
      // print(json.decode(response.body));
      // print("enddd");
      List<dynamic> body = json.decode(response.body);
      // print(body.toString() + ' body');
      List<Event> events =
          body.map((dynamic item) => Event.fromJson(item)).toList();
      // print(events.length.toString() + ' events fetched');
      // print(events.);
      return events;
    } else {
      throw Exception('Failed to load events');
    }
  }

  Future<dynamic> fetchMyEvents(int userId) async {
    // print("running fe");
    userId = 8;
    final url =
        Uri.parse('${ApiEndPoints.baseUrl}${AuthEndPoints.my_events}$userId/');
    final response = await http.get(url);
    // print(response.body);
    // print(response.statusCode.toString() + ' status code');
    if (response.statusCode == 200) {
      // print("code 200");
      // print(json.decode(response.body));
      // print("enddd");
      List<dynamic> body = json.decode(response.body);
      // print("xxx");
      // print(body);
      // print(body.toString() + ' body');

      // print(events.length.toString() + ' events fetched');

      return body;
    } else {
      throw Exception('Failed to load events');
    }
  }
}

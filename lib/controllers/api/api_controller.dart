// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api_endpoints.dart';
import 'package:http/http.dart' as http;

class ApiController extends GetxController {
  // Future<dynamic> myEvents(var userId) async {
  //   var url =
  //       Uri.parse("${ApiEndPoints.baseUrl}${AuthEndPoints.my_events}$userId");
  //   http.Response response = await http.get(url);
  //   print(response.body);
  //   print(url);
  //   print(response.statusCode);
  //   return response;
  // }

  Future<dynamic> eventsSpeakers(var eventId) async {
    var url = Uri.parse(
        "${ApiEndPoints.baseUrl}${AuthEndPoints.event_speaker_list}$eventId");
    http.Response response = await http.get(url);
    print(response.body);
    print(url);
    print(response.statusCode);
    return response;
    // Your code here
  }

  Future<dynamic> eventsImage(var eventId) async {
    var url = Uri.parse(
        "${ApiEndPoints.baseUrl}${AuthEndPoints.event_image_list}$eventId");
    http.Response response = await http.get(url);
    print(response.body);
    print(url);
    print(response.statusCode);
    return response;
    // Your code here
  }

  Future<http.Response> eventsRegister(var eventId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access');
    // final String accessToken = '1234';
    final String userId = '8';

    final data = {
      'event': eventId,
      'user': userId,
    };

    final url = Uri.parse(
        '${ApiEndPoints.baseUrl}${AuthEndPoints.register_event}$eventId/');
    // print(url.toString() + 'sss');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(data),
    );
    // print(response.body);

    if (response.statusCode == 200) {
      print("Registration successful");
    } else {
      print("Registration failed");
    }
    // var url = Uri.parse(
    //     "${ApiEndPoints.baseUrl}${AuthEndPoints.register_event}$eventId");
    // http.Response response = await http.post(url);
    // print(response.body);
    // print(url);
    // print(response.statusCode);
    return response;
  }

  Future<dynamic> eventsInterested(var eventId) async {
    var url = Uri.parse(
        "${ApiEndPoints.baseUrl}${AuthEndPoints.event_interested_list}$eventId");
    http.Response response = await http.get(url);
    print(response.body);
    print(url);
    print(response.statusCode);
    return response;
    // Your code here
  }

  Future<dynamic> eventsPost(var eventId) async {
    var url =
        Uri.parse("${ApiEndPoints.baseUrl}${AuthEndPoints.my_events}$eventId");
    // http.Response response = await http.get(url);
    // print(response.body);
    // print(url);
    // print(response.statusCode);
    // return response;
    // Your code here
  }

  Future<void> myTickets() async {
    // Your code here
  }

  Future<void> myProfile() async {
    // Your code here
  }

  Future<void> myUpdateProfile() async {
    // Your code here
  }

  Future<void> myUpdatePassword() async {
    // Your code here
  }

  Future<void> myUpdateEmail() async {
    // Your code here
  }

  Future<void> myUpdatePhone() async {
    // Your code here
  }

  Future<void> myUpdateAddress() async {
    // Your code here
  }

  Future<void> myUpdatePayment() async {
    // Your code here
  }

  Future<void> myUpdateNotification() async {
    // Your code here
  }

  Future<void> myUpdateLanguage() async {
    // Your code here
  }

  Future<void> myUpdateCurrency() async {
    // Your code here
  }

  Future<void> myUpdateTheme() async {
    // Your code here
  }

  Future<void> myUpdateLocation() async {
    // Your code here
  }

  Future<void> myUpdateSocial() async {
    // Your code here
  }

  Future<void> myUpdatePrivacy() async {
    // Your code here
  }

  Future<void> myUpdateTerms() async {
    // Your code here
  }

  Future<void> myUpdateAbout() async {
    // Your code here
  }

  Future<void> myUpdateHelp() async {
    // Your code here
  }

  Future<void> myUpdateFAQ() async {
    // Your code here
  }

  Future<void> myUpdateContact() async {
    // Your code here
  }
}

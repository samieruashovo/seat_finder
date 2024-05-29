import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:seat_finder/core/event_page_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api_endpoints.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> loginWithEmail() async {
    var headers = {'Content-Type': 'application/json'};
    try {
      var url = Uri.parse(ApiEndPoints.baseUrl + AuthEndPoints.loginEmail);
      print(url);
      Map body = {
        'email': emailController.text.trim(),
        'password': passwordController.text
      };
      print(body);
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      print(response.body);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        print("Login Success  ");
        var token = json['refresh'];
        final SharedPreferences? prefs = await _prefs;
        await prefs?.setString('token', token);

        // emailController.clear();
        // passwordController.clear();
        Get.offAll(EventPage());
      } else {
        throw jsonDecode(response.body)["Message"] ?? "Unknown Error Occured";
      }
    } catch (error) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error'),
              contentPadding: EdgeInsets.all(20),
              children: [Text(error.toString())],
            );
          });
    }
  }
}

// ignore_for_file: prefer_conditional_assignment

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:seat_finder/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _retypePasswordController =
      TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();

  @override
  void initState() {
    setUserInfo();
    super.initState();
  }

  Future setUserInfo() async {
    var userInfo = await getUserInfo("final@gmail.com");
    _usernameController.text = userInfo!['name'];
    _emailController.text = userInfo['email'];
    print(_usernameController.text);
  }

  Future<Map<String, dynamic>?> getUserInfo(String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access');
    print("${accessToken ?? "No token"} asasas");

    if (accessToken == null) {
      print("No access token available.");
      // Handle missing access token
      return null;
    }

    final url =
        Uri.parse('${ApiEndPoints.baseUrl}auth/users/by-username/$email/');
    print(url.toString() + " urllll");

    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken', // Use 'Bearer' for JWT tokens
      },
    );

    print("First attempt response:");
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      print("Access token expired or invalid.");
      // Handle token expiry, prompt user to log in again
    }

    print("Failed to load user info. Status code: ${response.statusCode}");
    return null;
  }

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  Future<void> changePassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access');
    print(accessToken);
    final url = Uri.parse('${ApiEndPoints.baseUrl}/auth/users/set_password/');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken', // Use 'Bearer' for JWT tokens
        },
        body: jsonEncode(<String, String>{
          'current_password': currentPasswordController.text,
          'new_password': newPasswordController.text,
        }),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  // Future<String?> refreshAccessToken() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? refreshToken = prefs.getString('access');
  //   if (refreshToken == null) {
  //     print("No refresh token available.");
  //     return null;
  //   }

  //   final response = await http.post(
  //     Uri.parse('${ApiEndPoints.baseUrl}auth/token/refresh/'),
  //     headers: {'Content-Type': 'application/json'},
  //     body: json.encode({'refresh': refreshToken}),
  //   );

  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     return data['access'];
  //   } else {
  //     print('Failed to refresh token. Status code: ${response.statusCode}');
  //     return null;
  //   }
  // }
  // Future<String?> refreshAccessToken() async {
  //   // Implement your token refresh logic here
  //   // For demonstration purposes, returning a dummy token
  //   final response = await http.post(
  //     Uri.parse('${ApiEndPoints.baseUrl}auth/token/refresh/'),
  //     headers: {'Content-Type': 'application/json'},
  //     body: json.encode({'refresh': 'your_refresh_token_here'}),
  //   );

  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     return data['access'];
  //   } else {
  //     print('Failed to refresh token. Status code: ${response.statusCode}');
  //     return null;
  //   }
  // }

  // Future<Map<String, dynamic>?> getUserInfo() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? accessToken = prefs.getString('access');
  //   print("${accessToken!} asasas");
  //   // If access token is not available, refresh it
  //   if (accessToken == null) {
  //     accessToken = await refreshAccessToken();
  //   }

  //   // if (accessToken == null) {
  //   //   // Handle missing access token
  //   //   return null;
  //   // }
  //   print(accessToken! + "accesstoken22");
  //   final url = Uri.parse('${ApiEndPoints.baseUrl}auth/users/me/');
  //   print(url.toString() + "urllll");
  //   final response = await http.get(
  //     url,
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Token $accessToken',
  //     },
  //   );
  //   print("lakaka");
  //   print(response.body);
  //   print(response.statusCode);

  //   if (response.statusCode == 200) {
  //     print("ueieie");
  //     print(response.body);
  //     return json.decode(response.body);
  //   } else if (response.statusCode == 401) {
  //     // Token might have expired, try refreshing it
  //     accessToken = await refreshAccessToken();

  //     if (accessToken != null) {
  //       final retryResponse = await http.get(
  //         Uri.parse('${ApiEndPoints.baseUrl}auth/users/me/'),
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'Authorization': 'Bearer $accessToken',
  //         },
  //       );

  //       if (retryResponse.statusCode == 200) {
  //         print("slskwe");
  //         return json.decode(retryResponse.body);
  //       }
  //     }
  //   }

  //   // Handle error
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Container(
          height: 800,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(8, 16, 43, 1.0),
                Color.fromRGBO(90, 0, 82, 1.0),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Image.asset(
                    "assets/eclipse_2.png",
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Image.asset("assets/profile_empty.png"),
                  ),
                ],
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    "My Profile",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              Container(
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xff67438C),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: _usernameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    labelText: _usernameController.text.isEmpty
                        ? 'Name'
                        : _usernameController.text,
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xff67438C),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    labelText: _emailController.text.isEmpty
                        ? 'Email'
                        : _emailController.text,
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // Container(
              //   height: 40,
              //   margin: const EdgeInsets.only(top: 20),
              //   decoration: const BoxDecoration(
              //     borderRadius: BorderRadius.all(Radius.circular(10.0)),
              //     gradient: LinearGradient(
              //       colors: [
              //         Color(0xff11BE22),
              //         Color(0xff3B63A0),
              //       ],
              //       begin: Alignment.centerLeft,
              //       end: Alignment.centerRight,
              //     ),
              //   ),
              //   child: ElevatedButton(
              //     onPressed: () {
              //       changePassword();
              //     },
              //     style: ElevatedButton.styleFrom(
              //         padding: const EdgeInsets.symmetric(
              //             horizontal: 60, vertical: 0),
              //         foregroundColor: Colors.transparent,
              //         backgroundColor: Colors.transparent,
              //         shape: const RoundedRectangleBorder(
              //           borderRadius: BorderRadius.all(Radius.circular(10.0)),
              //         )),
              //     child: const Text(
              //       'Save and Confirm',
              //       style: TextStyle(
              //         fontSize: 16,
              //         fontWeight: FontWeight.bold,
              //         color: Colors.white,
              //       ),
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Container(
              //   height: 37,
              //   margin: const EdgeInsets.symmetric(horizontal: 10),
              //   decoration: BoxDecoration(
              //     color: const Color(0xff67438C),
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: TextField(
              //     controller: currentPasswordController,
              //     decoration: const InputDecoration(
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.all(Radius.circular(10.0))),
              //       labelText: 'Current Password',
              //       labelStyle: TextStyle(color: Colors.white),
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Container(
              //   height: 37,
              //   margin: const EdgeInsets.symmetric(horizontal: 10),
              //   decoration: BoxDecoration(
              //     color: const Color(0xff67438C),
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: TextField(
              //     controller: newPasswordController,
              //     decoration: const InputDecoration(
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.all(Radius.circular(10.0))),
              //       labelText: 'New Password',
              //       labelStyle: TextStyle(color: Colors.white),
              //     ),
              //   ),
              // ),
              // // SizedBox(
              // //   height: 10,
              // // ),
              // // Container(
              // //   height: 37,
              // //   margin: const EdgeInsets.symmetric(horizontal: 10),
              // //   decoration: BoxDecoration(
              // //     color: const Color(0xff67438C),
              // //     borderRadius: BorderRadius.circular(10),
              // //   ),
              // //   child: TextField(
              // //     controller: _mobileNumberController,
              // //     decoration: const InputDecoration(
              // //       border: OutlineInputBorder(
              // //           borderRadius: BorderRadius.all(Radius.circular(10.0))),
              // //       labelText: 'Add Mobile Number',
              // //       labelStyle: TextStyle(color: Colors.white, fontSize: 14),
              // //     ),
              // //   ),
              // // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Container(
              //   height: 40,
              //   margin: const EdgeInsets.only(top: 20),
              //   decoration: const BoxDecoration(
              //     borderRadius: BorderRadius.all(Radius.circular(10.0)),
              //     gradient: LinearGradient(
              //       colors: [
              //         Color(0xff11BE22),
              //         Color(0xff3B63A0),
              //       ],
              //       begin: Alignment.centerLeft,
              //       end: Alignment.centerRight,
              //     ),
              //   ),
              //   child: ElevatedButton(
              //     onPressed: () {
              //       changePassword();
              //     },
              //     style: ElevatedButton.styleFrom(
              //         padding: const EdgeInsets.symmetric(
              //             horizontal: 60, vertical: 0),
              //         foregroundColor: Colors.transparent,
              //         backgroundColor: Colors.transparent,
              //         shape: const RoundedRectangleBorder(
              //           borderRadius: BorderRadius.all(Radius.circular(10.0)),
              //         )),
              //     child: const Text(
              //       'Save and Change Password',
              //       style: TextStyle(
              //         fontSize: 16,
              //         fontWeight: FontWeight.bold,
              //         color: Colors.white,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}



// import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
// import 'package:flutter/material.dart';

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Image.asset('assets/seatfinder 1.png'),
//       // ),
//       body: Scaffold(
//           backgroundColor: Colors.transparent,
//           extendBodyBehindAppBar: true,
//           body: Container(
//             height: double.infinity,
//             width: double.infinity,
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   Color.fromRGBO(8, 16, 43, 1.0),
//                   Color.fromRGBO(90, 0, 82, 1.0),
//                 ],
//               ),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//                 // SizedBox(
//                 //   height: 80,
//                 // ),
//                 // Align(
//                 //   alignment: Alignment.topRight,
//                 //   child: Image.asset("assets/profile_empty.png"),
//                 // ),
//                 Row(
//                   children: [
//                     Image.asset(
//                       "assets/eclipse_2.png",
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     Align(
//                       alignment: Alignment.topRight,
//                       child: Image.asset("assets/profile_empty.png"),
//                     ),
//                   ],
//                 ),
//                 const Align(
//                   alignment: Alignment.topLeft,
//                   child: Padding(
//                     padding: EdgeInsets.all(15.0),
//                     child: Text(
//                       "Edit Profile",
//                       style: TextStyle(fontSize: 20, color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   height: 37,
//                   margin: const EdgeInsets.symmetric(horizontal: 10),
//                   decoration: BoxDecoration(
//                     color: const Color(0xff67438C),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   // color: const Color(0xff67438C),
//                   child: const TextField(
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                           borderRadius:
//                               BorderRadius.all(Radius.circular(10.0))),
//                       // borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       labelText: 'Username',
//                       labelStyle: TextStyle(color: Colors.white),
//                       // fillColor: Colors.yellow,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   height: 37,
//                   margin: const EdgeInsets.symmetric(horizontal: 10),
//                   decoration: BoxDecoration(
//                     color: const Color(0xff67438C),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   // color: const Color(0xff67438C),
//                   child: const TextField(
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                           borderRadius:
//                               BorderRadius.all(Radius.circular(10.0))),
//                       // borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       labelText: 'Email',
//                       labelStyle: TextStyle(color: Colors.white),
//                       // fillColor: Colors.yellow,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   height: 37,
//                   margin: const EdgeInsets.symmetric(horizontal: 10),
//                   decoration: BoxDecoration(
//                     color: const Color(0xff67438C),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   // color: const Color(0xff67438C),
//                   child: const TextField(
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                           borderRadius:
//                               BorderRadius.all(Radius.circular(10.0))),
//                       // borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       labelText: 'Password',
//                       labelStyle: TextStyle(color: Colors.white),
//                       // fillColor: Colors.yellow,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   height: 37,
//                   margin: const EdgeInsets.symmetric(horizontal: 10),
//                   decoration: BoxDecoration(
//                     color: const Color(0xff67438C),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   // color: const Color(0xff67438C),
//                   child: const TextField(
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                           borderRadius:
//                               BorderRadius.all(Radius.circular(10.0))),
//                       // borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       labelText: 'Retype-Password',
//                       labelStyle: TextStyle(color: Colors.white),
//                       // fillColor: Colors.yellow,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   height: 37,
//                   margin: const EdgeInsets.symmetric(horizontal: 10),
//                   decoration: BoxDecoration(
//                     color: const Color(0xff67438C),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   // color: const Color(0xff67438C),
//                   child: const TextField(
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                           borderRadius:
//                               BorderRadius.all(Radius.circular(10.0))),
//                       // borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                       labelText: 'Add Mobile Number',
//                       labelStyle: TextStyle(color: Colors.white, fontSize: 14),
//                       // fillColor: Colors.yellow,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 100,
//                 ),
//                 Container(
//                   height: 40,
//                   margin: const EdgeInsets.only(top: 20),
//                   decoration: const BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                     gradient: LinearGradient(
//                       colors: [
//                         Color(0xff11BE22),
//                         Color(0xff3B63A0),
//                         // Color(0xff799993),
//                       ],
//                       begin: Alignment.centerLeft,
//                       end: Alignment.centerRight,
//                     ),
//                   ),
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 60, vertical: 0),
//                         foregroundColor: Colors.transparent,
//                         backgroundColor: Colors.transparent,
//                         shape: const RoundedRectangleBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                         )),
//                     child: const Text(
//                       'Save and Confirm',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )),
//     );
//   }
// }

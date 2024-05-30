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
    super.initState();
    _retrieveUserInfo();
    print("runnning xx");
  }

  Future<void> _retrieveUserInfo() async {
    final userInfo = await getUserInfo();
    print(userInfo);
    if (userInfo != null) {
      setState(() {
        _usernameController.text = userInfo['username'] ?? '';
        _emailController.text = userInfo['email'] ?? '';
        print(_usernameController.text);
        // Set other user details if needed
      });
    } else {
      // Handle error retrieving user info
    }
  }

  Future<String?> refreshAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? refreshToken = prefs.getString('token');
    print(refreshToken! + " ss");
    print("x");
    if (refreshToken == null) {
      // Handle missing refresh token
      return null;
    }

    final response = await http.post(
      Uri.parse(ApiEndPoints.baseUrl + 'auth/jwt/refresh/'),
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
    print(accessToken! + " asasas");
    // If access token is not available, refresh it
    if (accessToken == null) {
      accessToken = await refreshAccessToken();
    }

    if (accessToken == null) {
      // Handle missing access token
      return null;
    }

    final response = await http.get(
      Uri.parse(ApiEndPoints.baseUrl + 'auth/users/me/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    print(response.body);

    if (response.statusCode == 200) {
      print(response.body);
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      // Token might have expired, try refreshing it
      accessToken = await refreshAccessToken();

      if (accessToken != null) {
        final retryResponse = await http.get(
          Uri.parse(ApiEndPoints.baseUrl + 'auth/users/me/'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        body: Container(
          height: double.infinity,
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
                    "Edit Profile",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              Container(
                height: 37,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xff67438C),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    labelText: _usernameController.text.isEmpty
                        ? 'Username'
                        : _usernameController.text,
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 37,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xff67438C),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 37,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xff67438C),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 37,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xff67438C),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _retypePasswordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    labelText: 'Retype-Password',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 37,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xff67438C),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _mobileNumberController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    labelText: 'Add Mobile Number',
                    labelStyle: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Container(
                height: 40,
                margin: const EdgeInsets.only(top: 20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff11BE22),
                      Color(0xff3B63A0),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    // Implement save functionality
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 60, vertical: 0),
                      foregroundColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      )),
                  child: const Text(
                    'Save and Confirm',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
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

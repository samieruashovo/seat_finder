import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Image.asset('assets/seatfinder 1.png'),
      // ),
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
                // SizedBox(
                //   height: 80,
                // ),
                // Align(
                //   alignment: Alignment.topRight,
                //   child: Image.asset("assets/profile_empty.png"),
                // ),
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
                  // color: const Color(0xff67438C),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      // borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      labelText: 'Username',
                      labelStyle: TextStyle(color: Colors.white),
                      // fillColor: Colors.yellow,
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
                  // color: const Color(0xff67438C),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      // borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.white),
                      // fillColor: Colors.yellow,
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
                  // color: const Color(0xff67438C),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      // borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white),
                      // fillColor: Colors.yellow,
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
                  // color: const Color(0xff67438C),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      // borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      labelText: 'Retype-Password',
                      labelStyle: TextStyle(color: Colors.white),
                      // fillColor: Colors.yellow,
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
                  // color: const Color(0xff67438C),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      // borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      labelText: 'Add Mobile Number',
                      labelStyle: TextStyle(color: Colors.white, fontSize: 14),
                      // fillColor: Colors.yellow,
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
                        // Color(0xff799993),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
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
          )),
    );
  }
}

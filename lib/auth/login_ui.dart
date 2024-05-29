import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:seat_finder/auth/signup_ui.dart';

import '../controllers/auth/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController loginController = Get.put(LoginController());
  var isLogin = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 150),
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset('assets/seatfinder 1.png')),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 450,
              width: 320,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: const Color.fromARGB(0, 58, 20, 95).withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Container(
                    height: 95,
                    width: 295,
                    decoration: BoxDecoration(
                      color:
                          const Color.fromARGB(0, 58, 20, 95).withOpacity(0.93),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                        "Welcome back!! Please enter\nyour credentials to log in.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 42,
                    decoration: BoxDecoration(
                      color:
                          const Color.fromARGB(0, 58, 20, 95).withOpacity(0.77),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: loginController.emailController,
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.email),
                        focusedBorder: InputBorder.none,
                        hintText: 'Enter your email',
                        hintStyle: TextStyle(
                          color: Colors.white70, // Adjust this color as needed
                        ),
                        floatingLabelBehavior:
                            FloatingLabelBehavior.never, // Add this line
                      ),
                      style: TextStyle(
                        color: Colors
                            .white, // Adjust this color to your preferred text color
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 42,
                    decoration: BoxDecoration(
                      color:
                          const Color.fromARGB(0, 58, 20, 95).withOpacity(0.77),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: loginController.passwordController,
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        labelText: 'password',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.email),
                        focusedBorder: InputBorder.none,
                        hintText: 'Enter your password',
                        hintStyle: TextStyle(
                          color: Colors.white70, // Adjust this color as needed
                        ),
                        floatingLabelBehavior:
                            FloatingLabelBehavior.never, // Add this line
                      ),
                      style: TextStyle(
                        color: Colors
                            .white, // Adjust this color to your preferred text color
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 42,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(0, 97, 9, 138)
                              .withOpacity(0.77),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 10),
                          textStyle: const TextStyle(fontSize: 20),
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          )),
                      onPressed: () => loginController.loginWithEmail(),
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(SignupPage());
                    },
                    child: const Column(
                      children: [
                        Text(
                          "New to SeatFnder?",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "Create an account",
                          textAlign: TextAlign
                              .center, // Optional, adjusts text alignment
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationThickness: 3,
                              decorationColor: Colors.white,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

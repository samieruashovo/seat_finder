import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
              height: 500,
              width: 320,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: const Color.fromARGB(0, 58, 20, 95).withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
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
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.email),
                        focusedBorder: InputBorder.none,
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
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.people),
                        focusedBorder: InputBorder.none,
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
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.password_outlined),
                        focusedBorder: InputBorder.none,
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
                      decoration: const InputDecoration(
                        labelText: 'Retype Password',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.password_outlined),
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 43,
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
                      onPressed: () {},
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Row(
                      children: [
                        Text(
                          "Already Have an Account?",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          " Sign in",
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

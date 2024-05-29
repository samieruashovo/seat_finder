import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScanQrPage extends StatefulWidget {
  const ScanQrPage({super.key});

  @override
  State<ScanQrPage> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
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
                //   height: 10,
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 50, right: 20),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Image.asset(
                        'assets/back_1.png',
                        // width: 200,
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 30),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Image.asset(
                            'assets/nav_icon_1.png',
                            // width: 200,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, right: 30),
                      child: Container(
                        height: 45,
                        width: 157,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(0, 58, 20, 95)
                              .withOpacity(0.5),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                " My Name",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Container(
                                width: 72, // Increase the width
                                height: 100,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(0, 45, 42, 134)
                                      .withOpacity(1),
                                  shape: BoxShape.circle,
                                  // borderRadius: BorderRadius.circular(100),
                                ),
                                child: const Icon(
                                  Icons.person_2_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(30),
                      child: const Text(
                        "Scan Qr Code",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Image.asset("assets/qr_code_box.png"),
                    )
                  ],
                ),

                Container(
                    margin: const EdgeInsets.all(20),
                    height: 311,
                    width: 310,
                    decoration: BoxDecoration(
                      color: Colors.transparent.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(30),
                    child: Image.asset('assets/qr_code_2.jpg')),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Scan the qr code from your mobile and \n confirm your verification for the event",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          )),
    );
  }
}

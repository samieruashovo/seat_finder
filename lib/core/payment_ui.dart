import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
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
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    child: const Text(
                      "Edit Payment Method",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.all(20),
                  height: 405,
                  width: 326,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              height: 24,
                              width: 49,
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Image.asset("assets/visa.png")),
                          Container(
                              height: 25,
                              width: 50,
                              // padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  // color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Image.asset("assets/paypal.png")),
                          Container(
                              height: 25,
                              width: 50,
                              // padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  // color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Image.asset("assets/bkash.png")),
                          Container(
                              height: 25,
                              width: 50,
                              // padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  // color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Image.asset("assets/nagad.png")),
                        ],
                      ),
                      const TextField(
                        decoration: InputDecoration(
                          hintText: 'Card Number',
                          hintStyle: TextStyle(color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                      const TextField(
                        decoration: InputDecoration(
                          hintText: 'Card Holder Name',
                          hintStyle: TextStyle(color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                      const TextField(
                        decoration: InputDecoration(
                          hintText: 'Expiry Date',
                          hintStyle: TextStyle(color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                      const TextField(
                        decoration: InputDecoration(
                          hintText: 'CVV',
                          hintStyle: TextStyle(color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 40,
                        margin: const EdgeInsets.only(top: 20),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff339583),
                              Color(0xff418B40),
                              Color(0xff799993),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
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
              ],
            ),
          )),
    );
  }
}

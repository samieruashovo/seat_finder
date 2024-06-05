import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:seat_finder/controllers/api/api_controller.dart';
import 'package:seat_finder/payment/bkash_payment.dart';

import '../widgets/my_name.dart';

class PaymentPage extends StatefulWidget {
  final event;
  const PaymentPage({super.key, this.event});

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
                SizedBox(
                  height: 50,
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 50, right: 20),
                //   child: Align(
                //       alignment: Alignment.topRight,
                //       child: Image.asset(
                //         'assets/back_1.png',
                //         // width: 200,
                //       )),
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.only(top: 10, left: 30),
                //       child: Align(
                //           alignment: Alignment.topLeft,
                //           child: Image.asset(
                //             'assets/nav_icon_1.png',
                //             // width: 200,
                //           )),
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.only(top: 10, right: 30),
                //       child: Container(
                //         height: 45,
                //         width: 157,
                //         decoration: BoxDecoration(
                //           color: const Color.fromARGB(0, 58, 20, 95)
                //               .withOpacity(0.5),
                //           borderRadius: BorderRadius.circular(100),
                //         ),
                //         child: const Padding(
                //           padding: EdgeInsets.only(
                //             left: 10,
                //           ),
                //           child: MyName(),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    child: const Text(
                      "Pay with Bkash",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const BkashPaymentMethod(
                              title: "Bkash Pay",
                            )));
                  },
                  child: Container(
                      height: 405,
                      width: 326,
                      // padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          // color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: Image.asset("assets/bkash.jpg")),
                ),
              ],
            ),
          )),
    );
  }
}

// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:seat_finder/models/events.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api_endpoints.dart';
import '../controllers/api/api_controller.dart';
import '../widgets/my_name.dart';
import 'package:http/http.dart' as http;

import 'payment_ui.dart';

class EventDescriptionPage extends StatefulWidget {
  final Event event;

  const EventDescriptionPage({
    super.key,
    required this.event,
  });

  @override
  State<EventDescriptionPage> createState() => _EventDescriptionPageState();
}

class _EventDescriptionPageState extends State<EventDescriptionPage> {
  ApiController apiController = Get.put(ApiController());
  @override
  Widget build(BuildContext context) {
    // String buttonText = "Register";
    // bool buttonDisabled = false;

    // Future<void> handleRegistration() async {
    //   final SharedPreferences prefs = await SharedPreferences.getInstance();
    //   String? accessToken = prefs.getString('access');
    //   // final String accessToken = '1234';
    //   final String userId = '8';

    //   final data = {
    //     'event': widget.event.id,
    //     'user': userId,
    //   };

    //   final url = Uri.parse(
    //       '${ApiEndPoints.baseUrl}${AuthEndPoints.register_event}${widget.event.id}/');
    //   print(url.toString() + 'sss');
    //   // final response = await http.post(
    //   //   url,
    //   //   headers: {
    //   //     'Content-Type': 'application/json',
    //   //     'Authorization': 'Bearer $accessToken',
    //   //   },
    //   //   body: jsonEncode(data),
    //   // );
    //   print(url);

    //   // if (response.statusCode == 200) {
    //   //   print("Registration successful");
    //   //   setState(() {
    //   //     buttonText = "Registered";
    //   //     buttonDisabled = true;
    //   //   });
    //   // } else {
    //   //   print("Registration failed");
    //   // }
    // }
    // Map<String, double> dataMap = {
    //   "Artificial Intelligence": 5,
    //   "Research": 3,
    //   "Deep Learning": 2,
    //   "Research Writing": 2,
    // };

    // final colorList = <Color>[
    //   const Color(0xff84DD97),
    //   const Color(0xffE0BE68),
    //   const Color(0xffE06868),
    //   const Color(0xff68AEE0),
    //   const Color(0xff6c5ce7),
    // ];

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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 100),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Image.network(
                            fit: BoxFit.fill,
                            widget.event.thumb,
                            height: 400,
                            width: double.infinity,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 0, left: 30),
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Text("Event",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0, right: 10),
                          child: Container(
                            height: 45,
                            width: 157,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(0, 58, 20, 95)
                                  .withOpacity(0.5),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(
                                left: 10,
                              ),
                              child: MyName(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset('assets/location_1.png'),
                  ),
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context)
                          .size
                          .width, // Set max width to the screen width
                    ),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width *
                            0.30, // Set max width to the screen width
                      ),
                      child: Text(
                        widget.event.location,
                        style: TextStyle(color: Colors.white),
                        maxLines:
                            null, // Allows the text to span multiple lines
                        overflow: TextOverflow
                            .visible, // Ensures the text won't be clipped
                        softWrap: true, // Enables text wrapping
                      ),
                    ),
                  ),
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: Image.asset('assets/clock_1.png'),
                  // ),
                  // Text(
                  //   widget.event.time,
                  //   style: const TextStyle(color: Colors.white),
                  // ),
                  Container(
                    height: 50,
                    width: 70,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(0, 74, 200, 231)
                          .withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat.jm().format(DateFormat("HH:mm:ss'Z'")
                              .parseUtc(widget.event.date
                                  .split('-')[2]
                                  .substring(3, 12))),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 40,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(0, 74, 200, 231)
                          .withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.event.date.split('-')[2].substring(0, 2),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          widget.event.date.split('-')[1].toUpperCase(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 40,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(0, 74, 200, 231)
                          .withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        widget.event.date.split('-')[0].toUpperCase(),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 50,
                    // width: 200,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(0, 74, 200, 231)
                          .withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "At most " +
                            widget.event.capacity.toString() +
                            " can join",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              // const Align(
              //   alignment: Alignment.topLeft,
              //   child: Padding(
              //     padding: EdgeInsets.only(left: 30, bottom: 20),
              //     child: Text(
              //       "Category:",
              //       style: TextStyle(color: Colors.white),
              //     ),
              //   ),
              // ),
              // Align(
              //   alignment: Alignment.topRight,
              //   child: PieChart(
              //     dataMap: dataMap,
              //     animationDuration: const Duration(milliseconds: 800),
              //     chartLegendSpacing: 50,
              //     chartRadius: MediaQuery.of(context).size.width / 7.2,
              //     colorList: colorList,
              //     initialAngleInDegree: 0,
              //     chartType: ChartType.ring,
              //     ringStrokeWidth: 35,
              //     legendOptions: const LegendOptions(
              //       showLegendsInRow: false,
              //       legendPosition: LegendPosition.right,
              //       showLegends: true,
              //       legendShape: BoxShape.circle,
              //       legendTextStyle: TextStyle(
              //         fontWeight: FontWeight.bold,
              //         color: Colors.white,
              //         fontSize: 10,
              //       ),
              //     ),
              //     chartValuesOptions: const ChartValuesOptions(
              //       showChartValueBackground: true,
              //       showChartValues: false,
              //       showChartValuesInPercentage: false,
              //       showChartValuesOutside: false,
              //       decimalPlaces: 1,
              //     ),
              //   ),
              // ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Text(
                      "Description:",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Expanded(child: Container()),
                  // Image.asset("assets/chevron_down.png"),
                  // Image.asset("assets/chevron_up.png"),
                  // const SizedBox(width: 20),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(widget.event.description,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  minimumSize: const Size(300, 50),
                  side: const BorderSide(color: Color(0xffB9B0B0)),
                ),
                onPressed: () async {
                  if (widget.event.hasFee) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            PaymentPage(event: widget.event)));
                  } else {
                    if (widget.event.capacity <= 0) {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: const Text('Registration unsuccessful'),
                              content: Text("0 Seat Remaining"),
                              actions: [
                                TextButton(
                                  onPressed: Navigator.of(context).pop,
                                  child: const Text('Ok'),
                                ),
                              ],
                            );
                          });
                    } else {
                      http.Response res =
                          await apiController.eventsRegister(widget.event.id);
                      // print("ssssss");
                      // print(res.body);
                      if (res.statusCode == 201) {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                title: const Text('Registration Successful'),
                                content: const Text(
                                    'User has been registered successfully.'),
                                actions: [
                                  TextButton(
                                    onPressed: Navigator.of(context).pop,
                                    child: const Text('Ok'),
                                  ),
                                ],
                              );
                            });
                      } else {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                title: const Text('Registration unsuccessful'),
                                content: Text("Error Code: ${res.statusCode}"),
                                actions: [
                                  TextButton(
                                    onPressed: Navigator.of(context).pop,
                                    child: const Text('Ok'),
                                  ),
                                ],
                              );
                            });
                      }
                    }
                  }
                },
                child: const Text(
                  "Register Now",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

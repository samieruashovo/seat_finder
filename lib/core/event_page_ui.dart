import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seat_finder/auth/login_ui.dart';
import 'package:seat_finder/auth/signup_ui.dart';
import 'package:seat_finder/core/event_description_ui.dart';
import 'package:seat_finder/core/payment_ui.dart';
import 'package:seat_finder/core/profile_page.dart';

import '../api_services.dart';
import '../models/events.dart';
import '../widgets/my_name.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final _pageController = PageController(initialPage: 0);
  final TextEditingController _eventPassController = TextEditingController();
  late Future<List<Event>> futureEvents;

  /// Controller to handle bottom nav bar and also handles initial page
  // final NotchBottomBarController _controller =
  //     NotchBottomBarController(index: 0);

  int maxCount = 5;

  @override
  void initState() {
    futureEvents = ApiServices().fetchEvents();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> bottomBarPages = [
      const PaymentPage(),
      const SignupPage(),
      const PaymentPage(),
      // const EventDescriptionPage(),
      const LoginPage(),
    ];

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
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 30),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      'assets/seatfinder 1.png',
                      width: 200,
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 10, left: 30),
                  //   child: Align(
                  //       alignment: Alignment.topLeft,
                  //       child: InkWell(
                  //         // onTap: () {
                  //         //   Navigator.of(context).push(MaterialPageRoute(
                  //         //       builder: (context) => const ProfilePage()));
                  //         // },
                  //         child: Image.asset(
                  //           'assets/nav_icon_1.png',
                  //           // width: 200,
                  //         ),
                  //       )),
                  // ),
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
                        padding: const EdgeInsets.only(left: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ProfilePage()));
                          },
                          child: const MyName(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // const SizedBox(height: 20),
              // Container(
              //   width: 300,
              //   height: 40,
              //   // color: Colors.white,
              //   decoration: BoxDecoration(
              //     color:
              //         const Color.fromARGB(0, 229, 219, 219).withOpacity(0.2),
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: const Row(
              //     children: [
              //       Padding(
              //         padding: EdgeInsets.only(left: 10),
              //         child: Icon(
              //           Icons.search,
              //           color: Colors.white,
              //         ),
              //       ),
              //       Padding(
              //         padding: EdgeInsets.only(left: 10),
              //         child: Text(
              //           'Search for events or join by seatcode',
              //           style: TextStyle(color: Colors.white),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.only(left: 30),
                child: const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Events Happening",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FutureBuilder<List<Event>>(
                future: futureEvents,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('No events found');
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          Event event = snapshot.data![index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: InkWell(
                              onTap: () {
                                if (event.isPrivate) {
                                  showDialog(
                                      context: context,
                                      builder: (_) {
                                        return AlertDialog(
                                          title: const Text('Private Event'),
                                          content: Column(
                                            children: [
                                              Text(
                                                  'Give the Password to join the event '),
                                              TextField(
                                                controller:
                                                    _eventPassController,
                                              )
                                            ],
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                // print(event.pkey);
                                                // print(
                                                //     _eventPassController.text);
                                                if (event.pkey ==
                                                    _eventPassController.text) {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              EventDescriptionPage(
                                                                event: event,
                                                              )));
                                                } else {
                                                  Navigator.of(context).pop();
                                                }
                                              },
                                              child: const Text('Ok'),
                                            ),
                                          ],
                                        );
                                      });
                                } else {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          EventDescriptionPage(
                                            event: event,
                                          )));
                                }
                              },
                              child: Stack(
                                alignment: Alignment.bottomLeft,
                                children: [
                                  Image.network(event.thumb),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3, // set width according to your requirement
                                            child: Text(
                                              event.name,
                                              textAlign: TextAlign.justify,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                              maxLines:
                                                  null, // or specify the maximum number of lines you want
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 50,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                    0, 74, 200, 231)
                                                .withOpacity(0.7),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                DateFormat.jm().format(
                                                    DateFormat("HH:mm:ss'Z'")
                                                        .parseUtc(event.date
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
                                            color: const Color.fromARGB(
                                                    0, 74, 200, 231)
                                                .withOpacity(0.7),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                event.date
                                                    .split('-')[2]
                                                    .substring(0, 2),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              Text(
                                                event.date
                                                    .split('-')[1]
                                                    .toUpperCase(),
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

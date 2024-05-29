import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:seat_finder/auth/login_ui.dart';
import 'package:seat_finder/auth/signup_ui.dart';
import 'package:seat_finder/core/event_description_ui.dart';
import 'package:seat_finder/core/payment_ui.dart';
import 'package:seat_finder/core/profile_page.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final _pageController = PageController(initialPage: 0);

  /// Controller to handle bottom nav bar and also handles initial page
  final NotchBottomBarController _controller =
      NotchBottomBarController(index: 0);

  int maxCount = 5;
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
      const EventDescriptionPage(),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 30),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const ProfilePage()));
                            },
                            child: Image.asset(
                              'assets/nav_icon_1.png',
                              // width: 200,
                            ),
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
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: 300,
                  height: 40,
                  // color: Colors.white,
                  decoration: BoxDecoration(
                    color:
                        const Color.fromARGB(0, 229, 219, 219).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Search for events or join by seatcode',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 30),
                  child: const Align(
                    alignment: Alignment.topLeft,
                    child: Text("Events Happening",
                        style: TextStyle(color: Colors.white, fontSize: 24)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Image.asset(
                        'assets/image_1.png',
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                "Celestial Symposium: Exploring the\n Universe's Mysteries.",
                                style: TextStyle(color: Colors.white),
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
                              child: const Column(
                                children: [
                                  Text(
                                    '28',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    'JAN',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}

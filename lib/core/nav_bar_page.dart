import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:seat_finder/core/event_description_ui.dart';
import 'package:seat_finder/core/scanqr_ui.dart';

import '../auth/login_ui.dart';
import '../auth/signup_ui.dart';
import 'event_page_ui.dart';
import 'payment_ui.dart';

class NavBarPage extends StatefulWidget {
  const NavBarPage({Key? key}) : super(key: key);

  @override
  State<NavBarPage> createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  /// Controller to handle PageView and also handles initial page
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
    /// widget list
    final List<Widget> bottomBarPages = [
      // Page1(
      //   controller: (_controller),
      // ),
      const EventPage(),
      const EventDescriptionPage(),
      const ScanQrPage(),
      const PaymentPage(),
    ];
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              /// Provide NotchBottomBarController
              notchBottomBarController: _controller,
              color: Color.fromARGB(255, 87, 10, 81),
              showLabel: false,
              textOverflow: TextOverflow.visible,
              maxLine: 1,
              shadowElevation: 5,
              kBottomRadius: 28.0,

              notchShader: const SweepGradient(
                startAngle: 0,
                endAngle: 3.14 / 2,
                colors: [
                  Color.fromARGB(255, 87, 10, 81),
                  Color.fromARGB(255, 238, 131, 229),
                ],
                tileMode: TileMode.mirror,
              ).createShader(Rect.fromCircle(center: Offset.zero, radius: 8.0)),
              notchColor: Color.fromARGB(255, 87, 10, 81),

              /// restart app if you change removeMargins
              removeMargins: false,
              bottomBarWidth: 500,
              showShadow: false,
              durationInMilliSeconds: 300,
              itemLabelStyle: const TextStyle(fontSize: 10),

              elevation: 1,
              bottomBarItems: [
                BottomBarItem(
                  inActiveItem: Image.asset("assets/icons/Home.png"),
                  activeItem: Image.asset("assets/icons/Home.png"),
                  itemLabel: 'Page 1',
                ),
                BottomBarItem(
                  inActiveItem: Image.asset("assets/icons/bookmark_icon.png"),
                  activeItem: Image.asset("assets/icons/bookmark_icon.png"),
                  // itemLabel: 'Page 2',
                ),
                BottomBarItem(
                  inActiveItem:
                      Image.asset("assets/icons/notification_icon.png"),
                  activeItem: Image.asset("assets/icons/notification_icon.png"),
                  // itemLabel: 'Page 3',
                ),
                BottomBarItem(
                  inActiveItem: Image.asset("assets/icons/chair_icon.png"),
                  activeItem: Image.asset("assets/icons/chair_icon.png"),
                  // itemLabel: 'Page 4',
                ),
                // BottomBarItem(
                //   inActiveItem: Icon(
                //     Icons.person,
                //     color: Colors.blueGrey,
                //   ),
                //   activeItem: Icon(
                //     Icons.person,
                //     color: Colors.yellow,
                //   ),
                //   // itemLabel: 'Page 4',
                // ),
              ],
              onTap: (index) {
                // log('current selected index $index');
                _pageController.jumpToPage(index);
              },
              kIconSize: 24.0,
            )
          : null,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:seat_finder/auth/login_ui.dart';
import 'package:seat_finder/auth/signup_ui.dart';
import 'package:seat_finder/start_page.dart';

import 'core/event_description_ui.dart';
import 'core/event_page_ui.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
  FlutterNativeSplash.remove();
}
// FlutterNativeSplash.remove();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: SeatFinder());
  }
}

class SeatFinder extends StatelessWidget {
  const SeatFinder({super.key});

  @override
  Widget build(BuildContext context) {
    return EventDescriptionPage();
  }
}

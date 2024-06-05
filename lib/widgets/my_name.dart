import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seat_finder/core/profile_page.dart';

class MyName extends StatelessWidget {
  const MyName({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const ProfilePage())),
      child: Container(
        width: 72, // Increase the width
        height: 100,
        decoration: BoxDecoration(
          color: const Color.fromARGB(0, 45, 42, 134).withOpacity(1),
          shape: BoxShape.circle,
          // borderRadius: BorderRadius.circular(100),
        ),
        child: const Icon(
          Icons.person_2_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}

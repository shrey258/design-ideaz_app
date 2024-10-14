import 'dart:async';

import 'package:design_ideaz_app/screens/home_screen.dart';
import 'package:flutter/material.dart';

class Homesplash extends StatefulWidget {
  const Homesplash({super.key});

  @override
  State<Homesplash> createState() => _HomesplashState();
}

class _HomesplashState extends State<Homesplash> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 2),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return HomePage();
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Center(
          child: Image.asset("asset/images/desiznideaz logo.jpg"),
          // child: Text(
          //   "Desiznideaz",
          //   style: TextStyle(
          //       fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          // ),
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:parking_slot/Features/Screens/main_activity.dart';
import 'package:parking_slot/Features/Widgets/widgets_splash_screen.dart';
import 'package:parking_slot/Resources/colors.dart';

import 'file:///D:/Works/Project/parking_slot/lib/Features/Screens/Login/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    print("Splash");

    // Start full screen
    SystemChrome.setEnabledSystemUIOverlays([]);

    // Waiting screen for a moment
    loadScreen();
  }

  @override
  void dispose() {
    super.dispose();
    // Exit full screen
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          // Background color is creating
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [COLOR_CARIBBEAN_GREEN, COLOR_SHAMROCK],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Calling screen design widgets
              SplashLogo(),
              SplashTexts(),
            ],
          ),
        ),
      ),
    );
  }

  Future<Timer> loadScreen() async {
    return Timer(
      Duration(seconds: 4),
      () {
        print("3 seconds");
        if (FirebaseAuth.instance.currentUser == null)
          Get.off(
            LoginScreen(),
          );
        else
          Get.off(
            MainActivity(),
          );
      },
    );
  }
}

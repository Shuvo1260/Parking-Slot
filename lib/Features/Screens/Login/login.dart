import 'package:flutter/material.dart';
import 'package:parking_slot/Features/Widgets/widgets_login_registration.dart';
import 'package:parking_slot/Resources/colors.dart';
import 'package:parking_slot/Resources/strings.dart';

import 'LoginDesign.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [COLOR_CARIBBEAN_GREEN, COLOR_SHAMROCK],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Flexible(
                      flex: 1,
                      child: WidgetTopLogo(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        text: LOGIN_SCREEN_TOP_TEXT,
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: DesignLoginBottom(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

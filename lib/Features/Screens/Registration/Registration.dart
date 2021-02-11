import 'package:flutter/material.dart';
import 'package:parking_slot/Features/Screens/Registration/RegistrationDesign.dart';
import 'package:parking_slot/Features/Widgets/widgets_login_registration.dart';
import 'package:parking_slot/Resources/colors.dart';
import 'package:parking_slot/Resources/strings.dart';

class RegistrationScreen extends StatelessWidget {
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
                    minHeight: MediaQuery.of(context).size.height),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    WidgetTopLogo(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      text: REGISTRATION_SCREEN_TOP_TEXT,
                    ),
                    RegistrationDesign(),
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

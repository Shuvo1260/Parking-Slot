import 'package:flutter/material.dart';
import 'package:parking_slot/Resources/assets.dart';
import 'package:parking_slot/Resources/strings.dart';

// Building splash logo
class SplashLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Hero(
            tag: TAG_CAR_LOGO,
            child: Container(
              height: 300.0,
              // height: double.infinity,
              // Creating background cloud image
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(IMAGE_CAR_BACKGROUND_CLOUD),
                ),
              ),

              // creating car image
              child: Image.asset(
                IMAGE_LAUNCHER_ICON,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Build texts
class SplashTexts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _TextBuilder(text: APP_NAME, fontSize: 24.0),
          _TextBuilder(text: SPLASH_SCREEN_MESSAGE, fontSize: 18.0)
        ],
      ),
    );
  }
}

class _TextBuilder extends StatelessWidget {
  final double fontSize;
  final String text;
  _TextBuilder({@required this.text, @required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        fontFamily: FONT_BANK_GOTHIC,
      ),
    );
  }
}

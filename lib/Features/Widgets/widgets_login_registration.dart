import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking_slot/Resources/assets.dart';
import 'package:parking_slot/Resources/colors.dart';
import 'package:parking_slot/Resources/strings.dart';
import 'package:parking_slot/Resources/values.dart';

class WidgetTopLogo extends StatelessWidget {
  CrossAxisAlignment crossAxisAlignment;
  var text;
  WidgetTopLogo({@required this.crossAxisAlignment, @required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: crossAxisAlignment,
        children: [
          _WidgetCarLogo(),
          _WidgetTopText(text),
        ],
      ),
    );
  }
}

class _WidgetCarLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: TAG_CAR_LOGO,
      child: Container(
        child: Image.asset(
          IMAGE_LAUNCHER_ICON,
          height: 70.0,
        ),
      ),
    );
  }
}

class _WidgetTopText extends StatelessWidget {
  final String text;
  _WidgetTopText(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 34.0,
          fontWeight: FontWeight.bold,
          fontFamily: FONT_BANK_GOTHIC,
        ),
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  Function onPressed;
  var text;
  SubmitButton({@required this.onPressed, @required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [COLOR_CARIBBEAN_GREEN, COLOR_SHAMROCK],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: FlatButton(
        padding: EdgeInsets.symmetric(vertical: PADDING_VERTICAL_BUTTON),
        onPressed: () {
          onPressed();
        },
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: FONT_SIZE_BUTTON,
              fontWeight: FontWeight.bold,
              fontFamily: FONT_BANK_GOTHIC,
            ),
          ),
        ),
      ),
    );
  }
}

class LoginTextField extends StatelessWidget {
  Function onTextChange;
  var hint;
  var keyboardType;
  var obscure;

  LoginTextField(this.onTextChange,
      {this.hint, this.keyboardType, @required this.obscure});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: PADDING_HORIZONTAL_LOGIN_FIELDS,
          vertical: PADDING_VERTICAL_LOGIN_FIELDS,
        ),
        child: TextField(
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: hint,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintStyle: TextStyle(
              color: COLOR_SHAMROCK,
              fontFamily: FONT_BANK_GOTHIC,
            ),
          ),
          onChanged: (value) {
            onTextChange(value);
          },
          style: TextStyle(
            color: COLOR_CARIBBEAN_GREEN,
            fontSize: FONT_SIZE_LOGIN_FIELDS,
            fontFamily: FONT_BANK_GOTHIC,
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }
}

class BottomOption extends StatelessWidget {
  Function onPressed;
  var text;

  BottomOption({@required this.text, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: COLOR_CARIBBEAN_GREEN,
            fontSize: FONT_SIZE_LOGIN_BOTTOM_OPTION,
            fontWeight: FontWeight.bold,
            fontFamily: FONT_BANK_GOTHIC,
          ),
        ),
      ),
    );
  }
}

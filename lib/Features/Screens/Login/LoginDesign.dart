import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_slot/Features/Screens/Registration/Registration.dart';
import 'package:parking_slot/Features/Widgets/widgets_login_registration.dart';
import 'package:parking_slot/Resources/strings.dart';
import 'package:parking_slot/Resources/values.dart';
import 'package:parking_slot/Utils/AppManager.dart';
import 'package:parking_slot/Utils/AuthManager.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../main_activity.dart';

class DesignLoginBottom extends StatefulWidget {
  @override
  _DesignLoginBottomState createState() => _DesignLoginBottomState();
}

class _DesignLoginBottomState extends State<DesignLoginBottom> {
  var _email;
  var _password;

  AuthManager _authManager;

  @override
  void initState() {
    super.initState();
    _authManager = AuthManager();
  }

  void _signIn() async {
    if (_checkValidity()) {
      var progressDialog = ProgressDialog(
        context,
        type: ProgressDialogType.Normal,
        isDismissible: false,
      );
      progressDialog.style(message: "Signing...");
      progressDialog.show();
      String value = await _authManager.signIn(_email, _password);
      if (value == "Success") {
        AppManager.showToast(message: "Successfully logged in");
        progressDialog.hide();
        Get.off(MainActivity());
      } else {
        _showToast(value);
        progressDialog.hide();
      }
    }
  }

  bool _checkValidity() {
    if (_email == null) {
      _showToast("Email can't be empty");
      return false;
    }
    if (_password == null) {
      _showToast("Password can't be empty");
      return false;
    }

    if (!AppManager.isEmailValid(_email)) {
      _showToast("Please enter a valid email");
      return false;
    }

    if (_password.toString().length < 6) {
      _showToast("Password should be at least 6 characters");
      return false;
    }
    return true;
  }

  void _showToast(message) {
    AppManager.showToast(
      message: message,
      backgroundColor: Colors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(RADIUS_LOGIN_REGISTRATION_BOTTOM),
          topRight: Radius.circular(RADIUS_LOGIN_REGISTRATION_BOTTOM),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: PADDING_HORIZONTAL_LOGIN_BOTTOM,
          vertical: PADDING_VERTICAL_LOGIN_BOTTOM,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LoginTextField(
              (value) {
                setState(() {
                  _email = value;
                });
                print(value);
              },
              hint: HINT_EMAIL,
              keyboardType: TextInputType.emailAddress,
              obscure: false,
            ),
            SizedBox(
              height: 30.0,
            ),
            LoginTextField(
              (value) {
                setState(() {
                  _password = value;
                });
                print(value);
              },
              hint: HINT_PASSWORD,
              keyboardType: TextInputType.visiblePassword,
              obscure: true,
            ),
            SizedBox(
              height: 50.0,
            ),
            SubmitButton(
              text: HINT_LOGIN,
              onPressed: () {
                print("Pressed");
                _signIn();
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            BottomOption(
              text: CREATE_A_NEW_ACCOUNT,
              onPressed: () {
                Get.to(
                  RegistrationScreen(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

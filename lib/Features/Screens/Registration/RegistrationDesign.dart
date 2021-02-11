import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_slot/Data/Models/UserData.dart';
import 'package:parking_slot/Features/Screens/main_activity.dart';
import 'package:parking_slot/Features/Widgets/widgets_login_registration.dart';
import 'package:parking_slot/Resources/strings.dart';
import 'package:parking_slot/Resources/values.dart';
import 'package:parking_slot/Utils/AppManager.dart';
import 'package:parking_slot/Utils/AuthManager.dart';
import 'package:progress_dialog/progress_dialog.dart';

class RegistrationDesign extends StatefulWidget {
  @override
  _RegistrationDesignState createState() => _RegistrationDesignState();
}

class _RegistrationDesignState extends State<RegistrationDesign> {
  var _name;
  var _phone;
  var _email;
  var _license;
  var _password;

  AuthManager _authManager;

  @override
  void initState() {
    super.initState();
    _authManager = AuthManager();
  }

  void _signUpUser() async {
    print(
        "name: $_name email: $_email phoneNumber: $_phone, license: $_license, password: $_password");
    if (_checkValidity()) {
      var progressDialog = ProgressDialog(
        context,
        type: ProgressDialogType.Normal,
        isDismissible: false,
      );
      progressDialog.style(message: "Signing up...");
      progressDialog.show();
      var id = AppManager.emailToID(_email);
      if (!await _authManager.isUserExist(id)) {
        UserData userData = UserData(
          id: id,
          name: _name,
          phoneNumber: _phone,
          license: _license,
          email: _email,
          password: _password,
          imageUrl: null,
        );

        if (await _authManager.signUP(userData)) {
          AppManager.showToast(message: "Successfully signed up");
          progressDialog.hide();
          Get.off(MainActivity());
        } else {
          AppManager.showToast(
              message: "Signing failed", backgroundColor: Colors.red);
          progressDialog.hide();
        }
      } else {
        AppManager.showToast(
            message: "This email has registered before",
            backgroundColor: Colors.blue);
        progressDialog.hide();
      }
    }
  }

  bool _checkValidity() {
    if (_name == null) {
      _showToast("Name can't be empty");
      return false;
    }
    if (_phone == null) {
      _showToast("Phone can't be empty");
      return false;
    }
    if (_license == null) {
      _showToast("License can't be empty");
      return false;
    }
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
                  _name = value;
                });
              },
              hint: HINT_NAME,
              keyboardType: TextInputType.text,
              obscure: false,
            ),
            SizedBox(
              height: 30.0,
            ),
            LoginTextField(
              (value) {
                setState(() {
                  _phone = value;
                });
              },
              hint: HINT_PHONE,
              keyboardType: TextInputType.phone,
              obscure: false,
            ),
            SizedBox(
              height: 30.0,
            ),
            LoginTextField(
              (value) {
                setState(() {
                  _license = value;
                });
              },
              hint: HINT_LICENSE,
              keyboardType: TextInputType.text,
              obscure: false,
            ),
            SizedBox(
              height: 30.0,
            ),
            LoginTextField(
              (value) {
                setState(() {
                  _email = value;
                });
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
              },
              hint: HINT_PASSWORD,
              keyboardType: TextInputType.visiblePassword,
              obscure: true,
            ),
            SizedBox(
              height: 50.0,
            ),
            SubmitButton(
              text: HINT_REGISTRATION,
              onPressed: () => _signUpUser(),
            ),
            SizedBox(
              height: 20.0,
            ),
            BottomOption(
              text: ALREADY_HAVE_AN_ACCOUNT,
              onPressed: () => Get.back(),
            )
          ],
        ),
      ),
    );
  }
}

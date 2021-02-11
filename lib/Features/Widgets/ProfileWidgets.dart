import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_slot/Data/Models/UserData.dart';
import 'package:parking_slot/Features/Screens/Login/login.dart';
import 'package:parking_slot/Resources/assets.dart';
import 'package:parking_slot/Resources/colors.dart';
import 'package:parking_slot/Resources/strings.dart';
import 'package:parking_slot/Resources/values.dart';

import 'ViewPlaceWidgets.dart';

class UserNameImageWidget extends StatelessWidget {
  const UserNameImageWidget({
    Key key,
    @required UserData userData,
  })  : _userData = userData,
        super(key: key);

  final UserData _userData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(RADIUS_LIST_ITEM),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _ProfileImage(userData: _userData),
          _ProfileUserName(userData: _userData),
        ],
      ),
    );
  }
}

class _ProfileUserName extends StatelessWidget {
  const _ProfileUserName({
    Key key,
    @required UserData userData,
  })  : _userData = userData,
        super(key: key);

  final UserData _userData;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          _userData.name,
          style: TextStyle(
            color: COLOR_CARIBBEAN_GREEN,
            fontFamily: FONT_BANK_GOTHIC,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}

class _ProfileImage extends StatelessWidget {
  const _ProfileImage({
    Key key,
    @required UserData userData,
  })  : _userData = userData,
        super(key: key);

  final UserData _userData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SIZE_PROFILE_PICTURE,
      width: SIZE_PROFILE_PICTURE,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(_userData.imageUrl == null
              ? TEMP_PRO_PIC_URL
              : _userData.imageUrl),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class UserDetailsWidget extends StatelessWidget {
  const UserDetailsWidget({
    Key key,
    @required UserData userData,
  })  : _userData = userData,
        super(key: key);

  final UserData _userData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(RADIUS_LIST_ITEM),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DetailsTextWidget(icon: Icons.phone, data: _userData.phoneNumber),
          SizedBox(
            height: 10.0,
          ),
          DetailsTextWidget(data: _userData.license, icon: Icons.car_rental),
          SizedBox(
            height: 10.0,
          ),
          DetailsTextWidget(data: _userData.email, icon: Icons.email),
        ],
      ),
    );
  }
}

class SignOutWidget extends StatelessWidget {
  const SignOutWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(RADIUS_LIST_ITEM),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: FlatButton(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        onPressed: () {
          FirebaseAuth.instance.signOut();
          Get.off(
            LoginScreen(),
          );
        },
        child: Row(
          children: [
            Icon(Icons.exit_to_app),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              flex: 2,
              child: Text(
                SIGN_OUT,
                style: TextStyle(
                  color: COLOR_CARIBBEAN_GREEN,
                  fontSize: FONT_SIZE_SIGN_OUT,
                  fontFamily: FONT_BANK_GOTHIC,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

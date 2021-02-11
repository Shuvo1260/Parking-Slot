import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_slot/Controllers/UserController.dart';
import 'package:parking_slot/Data/Models/UserData.dart';
import 'package:parking_slot/Features/Widgets/ProfileWidgets.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserData _userData;
  final _userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();

    _fetchUserData();
    print("UserData: $_userData");
  }

  void _fetchUserData() async {
    _userData = _userController.userData.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          UserNameImageWidget(userData: _userData),
          UserDetailsWidget(userData: _userData),
          SignOutWidget()
        ],
      ),
    );
  }
}

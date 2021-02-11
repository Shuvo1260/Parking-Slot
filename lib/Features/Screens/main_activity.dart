import 'package:flutter/material.dart';
import 'package:parking_slot/Features/Screens/Parked/Parked.dart';
import 'package:parking_slot/Features/Screens/Profile/Profile.dart';
import 'package:parking_slot/Resources/assets.dart';
import 'package:parking_slot/Resources/colors.dart';
import 'package:parking_slot/Resources/strings.dart';
import 'package:parking_slot/Resources/values.dart';
import 'package:parking_slot/Utils/Utils.dart';

import 'Home/Home.dart';

class MainActivity extends StatefulWidget {
  @override
  _MainActivityState createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  var _navIndex = 0;
  var _appBarTitle = APPBAR_TITLES[0];
  var _BOTTOM_NAVIGATION_PAGES = [HomePage(), ParkedPage(), Profile()];

  void onNavigationTap(int index) {
    setState(() {
      _navIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          APPBAR_TITLES[_navIndex],
          style: TextStyle(
            fontFamily: FONT_BANK_GOTHIC,
            fontSize: FONT_SIZE_APPBAR,
          ),
        ),
        backgroundColor: COLOR_CARIBBEAN_GREEN,
      ),
      body: SafeArea(
        child: _BOTTOM_NAVIGATION_PAGES[_navIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: BOTTOM_NAVIGATION_ITEMS,
        type: BottomNavigationBarType.fixed,
        currentIndex: _navIndex,
        onTap: onNavigationTap,
      ),
    );
  }
}

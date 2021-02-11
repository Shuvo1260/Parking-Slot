import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_slot/Controllers/PlaceController.dart';
import 'package:parking_slot/Features/Screens/Home/ViewPlace.dart';
import 'package:parking_slot/Features/Widgets/HomeWidgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var placeListController = Get.put(PlaceController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Scaffold(
          body: GetX<PlaceController>(
            builder: (controller) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return FlatButton(
                    padding: EdgeInsets.all(0.0),
                    child: ViewPlaceListItem(controller.placeList[index]),
                    onPressed: () {
                      print(index);
                      Get.to(ViewPlace(),
                          arguments: controller.placeList[index]);
                    },
                  );
                },
                itemCount: controller.placeList.length,
              );
            },
          ),
        ),
      ),
    );
  }
}

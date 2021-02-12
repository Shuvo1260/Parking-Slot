import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:parking_slot/Controllers/ParkingListController.dart';
import 'package:parking_slot/Features/Screens/ViewBooking.dart';
import 'package:parking_slot/Features/Widgets/ParkingWidgets.dart';

class ParkedPage extends StatefulWidget {
  @override
  _ParkedPageState createState() => _ParkedPageState();
}

class _ParkedPageState extends State<ParkedPage> {
  final parkingController = Get.put(ParkingListController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: GetX<ParkingListController>(
          builder: (controller) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return FlatButton(
                  padding: EdgeInsets.all(0.0),
                  child: ParkingPlaceListItem(controller.parkingList[index]),
                  onPressed: () {
                    print(index);
                    Get.to(ViewBooking(),
                        arguments: controller.parkingList[index]);
                  },
                );
              },
              itemCount: controller.parkingList.length,
            );
          },
        ),
      ),
    );
  }
}

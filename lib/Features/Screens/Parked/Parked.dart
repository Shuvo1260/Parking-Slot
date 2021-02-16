import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_slot/Controllers/ParkingListController.dart';
import 'package:parking_slot/Data/Models/ParkingData.dart';
import 'package:parking_slot/Features/Screens/ViewBooking.dart';
import 'package:parking_slot/Features/Widgets/ParkingWidgets.dart';
import 'package:parking_slot/Utils/LifeCycleHandler.dart';

class ParkedPage extends StatefulWidget {
  @override
  _ParkedPageState createState() => _ParkedPageState();
}

class _ParkedPageState extends State<ParkedPage> with WidgetsBindingObserver {
  final parkingController = Get.put(ParkingListController());

  List<ParkingData> parkingList = List<ParkingData>();

  @override
  void initState() {
    super.initState();
  }

  void getValue() async {
    var values = await parkingController.fetchList();
    setState(() {
      parkingList = values;
    });
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance
        .addObserver(LifecycleEventHandler(resumeCallBack: () async {
      var values = await parkingController.fetchList();
      print("ParkingValues: ${values.length}");
      setState(() {
        parkingList = values;
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    getValue();
    return Container(
      child: Scaffold(
        body: ListView.builder(
          itemBuilder: (context, index) {
            return FlatButton(
              padding: EdgeInsets.all(0.0),
              child: ParkingPlaceListItem(parkingList[index]),
              onPressed: () {
                print(index);
                Get.to(ViewBooking(), arguments: parkingList[index]);
              },
            );
          },
          itemCount: parkingList.length,
        ),
      ),
    );
  }
}

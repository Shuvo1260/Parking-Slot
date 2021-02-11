import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_slot/Data/Models/PlacesData.dart';
import 'package:parking_slot/Data/Sources/Remote/PlaceDataManager.dart';
import 'package:parking_slot/Features/Widgets/ViewPlaceWidgets.dart';
import 'package:parking_slot/Resources/assets.dart';
import 'package:parking_slot/Resources/colors.dart';
import 'package:parking_slot/Resources/strings.dart';
import 'package:parking_slot/Resources/values.dart';
import 'package:parking_slot/Utils/AppManager.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ViewPlace extends StatefulWidget {
  @override
  _ViewPlaceState createState() => _ViewPlaceState();
}

class _ViewPlaceState extends State<ViewPlace> {
  PlaceData _placeData;
  @override
  void initState() {
    super.initState();
    this._placeData = Get.arguments;
    print(_placeData.address);
  }

  Future<void> showDeleteDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("Do you want to delete?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
                deleteData();
              },
              child: Text("Yes"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: Text("No"),
            ),
          ],
        );
      },
    );
  }

  void deleteData() async {
    var progressDialog = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
    );
    progressDialog.style(message: "Deleting data...");
    progressDialog.show();
    if (await PlaceDataManager.deleteData(_placeData.id)) {
      AppManager.showToast(message: "Successfully deleted");
      progressDialog.hide();
      Get.back();
    } else {
      AppManager.showToast(
          message: "Operation failed", backgroundColor: Colors.red);
      progressDialog.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          APPBAR_PLACE,
          style: TextStyle(
            fontFamily: FONT_BANK_GOTHIC,
            fontSize: FONT_SIZE_APPBAR,
          ),
        ),
        backgroundColor: COLOR_CARIBBEAN_GREEN,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              showDeleteDialog();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ViewPlaceImage(placeData: _placeData),
              SizedBox(
                height: 10.0,
              ),
              ViewPlaceDetails(placeData: _placeData),
              ViewPlaceSlotWidget(placeData: _placeData),
            ],
          ),
        ),
      ),
    );
  }
}

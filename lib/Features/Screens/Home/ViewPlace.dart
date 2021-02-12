import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_slot/Controllers/ParkingController.dart';
import 'package:parking_slot/Controllers/UserController.dart';
import 'package:parking_slot/Data/Models/PlacesData.dart';
import 'package:parking_slot/Features/Widgets/ViewPlaceWidgets.dart';
import 'package:parking_slot/Features/Widgets/widgets_login_registration.dart';
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
  final _parkingController = Get.put(ParkingController());
  final _userController = Get.put(UserController());
  var _context;
  @override
  void initState() {
    super.initState();
    this._placeData = Get.arguments;
    print(_placeData.address);
  }

  Future<bool> _bookParkingSlot() async {
    var progressDialog = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
    );
    progressDialog.style(message: "Booking slot...");
    progressDialog.show();
    var id = DateTime.now().microsecondsSinceEpoch;
    if (await _parkingController.bookSlot(
      id,
      _placeData,
      _userController.userData.value,
    )) {
      progressDialog.hide();
      _showDialog(id);
      return true;
    } else {
      _showToast("Booking slot is failed.");
      progressDialog.hide();
      return false;
    }
  }

  void _showToast(message) {
    AppManager.showToast(
      message: message,
      backgroundColor: Colors.red,
    );
  }

  Future<void> _showDialog(id) async {
    return showDialog(
        context: _context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Parking slot booked successfully!"),
            content: Text(
                "You have booked a slot in ${_placeData.address}. Your booking id is $id. Please wait for the approval."),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    this._context = context;
    void _showSnackBar() {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
              "You have booked a parking slot. Please wait for the approval.")));
    }

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
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 20.0,
                ),
                child: SubmitButton(
                    onPressed: () async {
                      if (await _bookParkingSlot()) {
                        _showSnackBar();
                      }
                    },
                    text: "Book a slot"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

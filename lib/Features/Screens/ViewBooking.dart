import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_slot/Data/Models/ParkingData.dart';
import 'package:parking_slot/Resources/assets.dart';
import 'package:parking_slot/Resources/colors.dart';
import 'package:parking_slot/Resources/strings.dart';
import 'package:parking_slot/Resources/values.dart';
import 'package:parking_slot/Utils/AppManager.dart';
import 'package:parking_slot/Utils/BookingManager.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ViewBooking extends StatefulWidget {
  @override
  _ViewBookingState createState() => _ViewBookingState();
}

class _ViewBookingState extends State<ViewBooking> {
  ParkingData _parkingData;

  @override
  void initState() {
    super.initState();
    this._parkingData = Get.arguments;
    print(_parkingData.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            _parkingData.id.toString(),
            style: TextStyle(
              fontFamily: FONT_BANK_GOTHIC,
              fontSize: FONT_SIZE_APPBAR,
            ),
          ),
          backgroundColor: COLOR_CARIBBEAN_GREEN,
        ),
        body: SafeArea(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      )
                    ],
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  margin:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Token: #${_parkingData.id}",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Park owner phone: +88${_parkingData.parkOwnerNumber}",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Car owner phone: +88${_parkingData.carOwnerNumber}",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Parking rate: $SIGN_TAKA ${_parkingData.rate}",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Started time: ${_parkingData.startTime}",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "End time: ${_parkingData.endTime}",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Option(_parkingData),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Option extends StatefulWidget {
  ParkingData _parkingData;
  Option(this._parkingData);
  @override
  _OptionState createState() => _OptionState(_parkingData);
}

class _OptionState extends State<Option> {
  _OptionState(this._parkingData);
  ParkingData _parkingData;
  var _context;

  Future<void> _showDialog(rate) async {
    return showDialog(
        context: _context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Parking bill: $rate"),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    if (_parkingData.status == 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _ParkingButton(
            text: "Cancel",
            colorFirst: Colors.red,
            colorSecond: Colors.redAccent,
            onPressed: () async {
              var progressDialog = ProgressDialog(
                context,
                type: ProgressDialogType.Normal,
                isDismissible: false,
              );
              progressDialog.style(message: "Cancelling parking book...");
              progressDialog.show();
              if (await BookingManager.cancelBooking(
                  _parkingData.id.toString())) {
                AppManager.showToast(message: "Booking Cancelled");
                progressDialog.hide();
                Get.back();
              } else {
                AppManager.showToast(
                    message: "Operation failed", backgroundColor: Colors.red);
                progressDialog.hide();
              }
            },
          ),
        ],
      );
    } else if (_parkingData.status == 1) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                "You are allowed to park. Please park your car and click on \"Marked as Parked\"",
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          _ParkingButton(
            text: "Mark as Parked",
            colorFirst: COLOR_CARIBBEAN_GREEN,
            colorSecond: COLOR_CARIBBEAN_GREEN,
            onPressed: () async {
              var progressDialog = ProgressDialog(
                context,
                type: ProgressDialogType.Normal,
                isDismissible: false,
              );
              progressDialog.style(message: "Parking car...");
              progressDialog.show();
              setState(() {
                _parkingData.status++;
                _parkingData.startTime =
                    "Date: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}, "
                    "Time: ${DateTime.now().hour}:${DateTime.now().minute}";
              });
              if (await BookingManager.updateBooking(
                  _parkingData.id.toString(),
                  _parkingData.status,
                  DateTime.now().microsecondsSinceEpoch,
                  0,
                  _parkingData.startTime,
                  _parkingData.endTime,
                  _parkingData.placeId)) {
                AppManager.showToast(message: "Car is parked");
                progressDialog.hide();
              } else {
                AppManager.showToast(
                    message: "Operation failed", backgroundColor: Colors.red);
                progressDialog.hide();
              }
            },
          ),
        ],
      );
    } else if (_parkingData.status == 2) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                "You have parked. Pick your car and click on \"Marked as Picked\"",
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          _ParkingButton(
            text: "Mark as Picked",
            colorFirst: COLOR_CARIBBEAN_GREEN,
            colorSecond: COLOR_CARIBBEAN_GREEN,
            onPressed: () async {
              var progressDialog = ProgressDialog(
                context,
                type: ProgressDialogType.Normal,
                isDismissible: false,
              );
              progressDialog.style(message: "Picking up car...");
              progressDialog.show();
              setState(() {
                _parkingData.status++;
                _parkingData.endTime =
                    "Date: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}, "
                    "Time: ${DateTime.now().hour}:${DateTime.now().minute}";
              });
              var endTime = DateTime.now().microsecondsSinceEpoch;
              var minute = (endTime - _parkingData.startTimeInMilli) / 60000000;
              print("ParkingTime: $minute");
              double rate = (minute / 60) * _parkingData.rate;
              if (await BookingManager.updateBooking(
                  _parkingData.id.toString(),
                  _parkingData.status,
                  _parkingData.startTimeInMilli,
                  endTime,
                  _parkingData.startTime,
                  _parkingData.endTime,
                  _parkingData.placeId)) {
                AppManager.showToast(message: "Car picked up");
                progressDialog.hide();
                _showDialog(rate.ceil());
              } else {
                AppManager.showToast(
                    message: "Operation failed", backgroundColor: Colors.red);
                progressDialog.hide();
              }
            },
          ),
        ],
      );
    } else if (_parkingData.status == 3) {
      var endTime = _parkingData.endTimeInMilli;
      var minute = (endTime - _parkingData.startTimeInMilli) / 60000000;
      print("ParkingTime: $minute");
      double rate = (minute / 60) * _parkingData.rate;
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "You have Picked your car",
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Bill: " + rate.ceil().toString() + SIGN_TAKA,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          )
        ],
      );
    } else if (_parkingData.status == 4) {
      return Column(
        children: [
          Center(
            child: Text(
              "Request cancelled",
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 24.0,
                  fontFamily: FONT_BANK_GOTHIC),
            ),
          ),
        ],
      );
    } else {
      return Text(
        "Parking rate: $SIGN_TAKA ${_parkingData.rate}",
        style: TextStyle(
          fontSize: 16.0,
        ),
      );
    }
  }
}

class _ParkingButton extends StatelessWidget {
  var colorFirst;
  var colorSecond;
  var text;
  Function onPressed;
  _ParkingButton(
      {this.text, this.colorFirst, this.colorSecond, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [colorFirst, colorSecond],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: FlatButton(
        padding: EdgeInsets.all(10.0),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_slot/Data/Models/ParkingData.dart';
import 'package:parking_slot/Resources/assets.dart';
import 'package:parking_slot/Resources/colors.dart';
import 'package:parking_slot/Resources/strings.dart';
import 'package:parking_slot/Resources/values.dart';

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
                        "Park ower phone: +88${_parkingData.parkOwnerNumber}",
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
                    ],
                  ),
                ),
                _Option(parkingData: _parkingData),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Option extends StatelessWidget {
  const _Option({
    Key key,
    @required ParkingData parkingData,
  })  : _parkingData = parkingData,
        super(key: key);

  final ParkingData _parkingData;

  @override
  Widget build(BuildContext context) {
    if (_parkingData.status == 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _ParkingButton(
            text: "Cancel",
            colorFirst: Colors.red,
            colorSecond: Colors.redAccent,
            onPressed: () {},
          ),
        ],
      );
    } else if (_parkingData.status == 4) {
      return Center(
        child: Text(
          "Cancelled",
          style: TextStyle(
              color: Colors.red, fontSize: 24.0, fontFamily: FONT_BANK_GOTHIC),
        ),
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
        padding: EdgeInsets.all(0.0),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

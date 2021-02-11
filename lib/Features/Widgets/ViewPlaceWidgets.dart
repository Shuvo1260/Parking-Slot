import 'package:flutter/material.dart';
import 'package:parking_slot/Data/Models/PlacesData.dart';
import 'package:parking_slot/Resources/assets.dart';
import 'package:parking_slot/Resources/colors.dart';
import 'package:parking_slot/Resources/strings.dart';
import 'package:parking_slot/Resources/values.dart';

class ViewPlaceImage extends StatelessWidget {
  const ViewPlaceImage({
    Key key,
    @required PlaceData placeData,
  })  : _placeData = placeData,
        super(key: key);

  final PlaceData _placeData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: HEIGHT_PARKING_PLACE_IMAGE,
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
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(RADIUS_LIST_ITEM),
        ),
        child: Image.network(
          _placeData.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class ViewPlaceDetails extends StatelessWidget {
  const ViewPlaceDetails({
    Key key,
    @required PlaceData placeData,
  })  : _placeData = placeData,
        super(key: key);

  final PlaceData _placeData;

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
          DetailsTextWidget(icon: Icons.phone, data: _placeData.phoneNumber),
          SizedBox(
            height: 10.0,
          ),
          DetailsTextWidget(data: _placeData.address, icon: Icons.location_on),
          SizedBox(
            height: 10.0,
          ),
          DetailsTextWidget(
              data: "${_placeData.rate} $SIGN_TAKA per hour",
              icon: Icons.attach_money),
        ],
      ),
    );
  }
}

class DetailsTextWidget extends StatelessWidget {
  DetailsTextWidget({@required this.data, @required this.icon});

  String data;
  var icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Text(
            data,
            style: TextStyle(
              color: COLOR_BLACK,
              fontSize: FONT_SIZE_VIEW_PLACE_DETAILS,
            ),
          ),
        ),
      ],
    );
  }
}

class ViewPlaceSlotWidget extends StatelessWidget {
  const ViewPlaceSlotWidget({
    Key key,
    @required PlaceData placeData,
  })  : _placeData = placeData,
        super(key: key);

  final PlaceData _placeData;

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
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(
              TITLE_SLOT_DETAILS,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: FONT_SIZE_VIEW_PLACE_SLOT_TITLE,
                color: COLOR_CARIBBEAN_GREEN,
                fontFamily: FONT_BANK_GOTHIC,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          _SlotWidgets(placeData: _placeData),
        ],
      ),
    );
  }
}

class _SlotWidgets extends StatelessWidget {
  const _SlotWidgets({
    Key key,
    @required PlaceData placeData,
  })  : _placeData = placeData,
        super(key: key);

  final PlaceData _placeData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _SlotWidget(
          title: TITLE_TOTAL_SLOT,
          slot: _placeData.totalSlot.toString(),
        ),
        SizedBox(
          width: 10.0,
        ),
        _SlotWidget(
          title: TITLE_PARKED_SLOT,
          slot: _placeData.parkedSlot.toString(),
        ),
      ],
    );
  }
}

class _SlotWidget extends StatelessWidget {
  _SlotWidget({@required this.title, @required this.slot});

  var title;
  var slot;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              slot,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

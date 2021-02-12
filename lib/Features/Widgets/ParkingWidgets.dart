import 'package:flutter/material.dart';
import 'package:parking_slot/Data/Models/ParkingData.dart';
import 'package:parking_slot/Resources/strings.dart';
import 'package:parking_slot/Resources/values.dart';

class ParkingPlaceListItem extends StatelessWidget {
  ParkingData parkingData;

  ParkingPlaceListItem(this.parkingData);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
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
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            _ListItemImage(parkingData: parkingData),
            _ListItemFields(parkingData: parkingData),
          ],
        ),
      ),
    );
  }
}

class _ListItemFields extends StatelessWidget {
  const _ListItemFields({
    Key key,
    @required this.parkingData,
  }) : super(key: key);

  final ParkingData parkingData;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ParkingListText(
              "Token: #${parkingData.id}",
              fontSize: FONT_SIZE_LIST_ITEM_RATE,
            ),
            SizedBox(
              height: 10.0,
            ),
            _ParkingListText(
              "Address: ${parkingData.address}",
              fontSize: FONT_SIZE_LIST_ITEM_RATE,
            ),
            SizedBox(
              height: 10.0,
            ),
            _ParkingListText(
              "Status: " + PARKING_STATUS[parkingData.status],
              fontSize: FONT_SIZE_LIST_ITEM_RATE,
            ),
          ],
        ),
      ),
    );
  }
}

class _ListItemImage extends StatelessWidget {
  const _ListItemImage({
    Key key,
    @required this.parkingData,
  }) : super(key: key);

  final ParkingData parkingData;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(RADIUS_LIST_ITEM),
        bottomLeft: Radius.circular(RADIUS_LIST_ITEM),
      ),
      child: Image.network(
        parkingData.imageUrl,
        height: HEIGHT_PARKING_LIST_ITEM_IMAGE,
        width: WIDTH_PARKING_LIST_ITEM_IMAGE,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _ParkingListText extends StatelessWidget {
  var data;
  var fontSize;
  _ParkingListText(this.data, {@required this.fontSize});
  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        color: Colors.black,
        fontSize: fontSize,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}

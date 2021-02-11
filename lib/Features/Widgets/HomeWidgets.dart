import 'package:flutter/material.dart';
import 'package:parking_slot/Data/Models/PlacesData.dart';
import 'package:parking_slot/Resources/assets.dart';
import 'package:parking_slot/Resources/colors.dart';
import 'package:parking_slot/Resources/strings.dart';
import 'package:parking_slot/Resources/values.dart';

class ViewPlaceListItem extends StatelessWidget {
  PlaceData placeData;

  ViewPlaceListItem(this.placeData);

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
            _ListItemImage(placeData: placeData),
            _ListItemFields(placeData: placeData)
          ],
        ),
      ),
    );
  }
}

class _ListItemFields extends StatelessWidget {
  const _ListItemFields({
    Key key,
    @required this.placeData,
  }) : super(key: key);

  final PlaceData placeData;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PlaceListText(
              placeData.address,
              fontSize: FONT_SIZE_LIST_ITEM_ADDRESS,
            ),
            SizedBox(
              height: 10.0,
            ),
            _PlaceListText(
              SIGN_TAKA + placeData.rate.toString(),
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
    @required this.placeData,
  }) : super(key: key);

  final PlaceData placeData;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(RADIUS_LIST_ITEM),
        bottomLeft: Radius.circular(RADIUS_LIST_ITEM),
      ),
      child: Image.network(
        placeData.imageUrl,
        height: HEIGHT_PARKING_LIST_ITEM_IMAGE,
        width: WIDTH_PARKING_LIST_ITEM_IMAGE,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _PlaceListText extends StatelessWidget {
  var data;
  var fontSize;
  _PlaceListText(this.data, {@required this.fontSize});
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

class SearchField extends StatelessWidget {
  Function onTextChange;

  SearchField({this.onTextChange});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: PADDING_HORIZONTAL_LOGIN_FIELDS,
          vertical: PADDING_VERTICAL_LOGIN_FIELDS,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintStyle: TextStyle(
                    color: COLOR_SHAMROCK,
                    fontFamily: FONT_BANK_GOTHIC,
                  ),
                ),
                onChanged: (value) {
                  onTextChange(value);
                },
                style: TextStyle(
                  color: COLOR_CARIBBEAN_GREEN,
                  fontSize: FONT_SIZE_LOGIN_FIELDS,
                  fontFamily: FONT_BANK_GOTHIC,
                ),
              ),
            ),
            Icon(
              Icons.search,
              color: COLOR_CARIBBEAN_GREEN,
            ),
          ],
        ),
      ),
    );
  }
}

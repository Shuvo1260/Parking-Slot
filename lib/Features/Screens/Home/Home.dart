import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_slot/Controllers/PlaceController.dart';
import 'package:parking_slot/Data/Models/PlacesData.dart';
import 'package:parking_slot/Features/Widgets/HomeWidgets.dart';

import 'ViewPlace.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var placeListController = PlaceController();
  var _searchValue;

  List<PlaceData> _placeList = List<PlaceData>();

  @override
  void initState() {
    super.initState();
    placeListController.fetchPlaceList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SearchField(
              onTextChange: (value) {
                setState(() {
                  _searchValue = value;
                });
              },
              onSearchClick: () async {
                print("PlaceList $_searchValue");
                var values = await placeListController.getList(_searchValue);
                setState(() {
                  _placeList = values;
                });
              },
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return FlatButton(
                    padding: EdgeInsets.all(0.0),
                    child: ViewPlaceListItem(_placeList[index]),
                    onPressed: () {
                      print(index);
                      Get.to(ViewPlace(), arguments: _placeList[index]);
                    },
                  );
                },
                itemCount: _placeList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

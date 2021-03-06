import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:parking_slot/Data/Models/PlacesData.dart';
import 'package:parking_slot/Resources/strings.dart';

class PlaceController extends GetxController {
  var placeList = List<PlaceData>().obs;
  var _allPlaceList = List<PlaceData>();
  FirebaseAuth _firebaseAuth;
  @override
  void onInit() {
    super.onInit();
    _firebaseAuth = FirebaseAuth.instance;
  }

  void fetchPlaceList() async {
    FirebaseFirestore.instance
        .collection(PATH_PLACE_DATA)
        .snapshots(includeMetadataChanges: true)
        .listen((querySnapshot) {
      placeList.clear();
      querySnapshot.docs.forEach((element) {
        print(element.data());
        PlaceData placeData = PlaceData();
        placeData.fromJSON(element.data());
        _allPlaceList.add(placeData);
      });
    });
  }

  Future<List<PlaceData>> getList(String place) async {
    placeList.clear();
    if (place.isNotEmpty && place != null) {
      _allPlaceList.forEach((element) {
        print("Place: ${element.address}");
        if (element.address
            .toString()
            .toLowerCase()
            .contains(place.toLowerCase())) {
          placeList.add(element);
        }
      });
      return placeList;
    }
  }
}

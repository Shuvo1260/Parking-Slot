import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:parking_slot/Data/Models/PlacesData.dart';
import 'package:parking_slot/Resources/strings.dart';

class PlaceController extends GetxController {
  var placeList = List<PlaceData>().obs;
  FirebaseAuth _firebaseAuth;
  @override
  void onInit() {
    super.onInit();
    _firebaseAuth = FirebaseAuth.instance;
    _fetchPlaceList();
  }

  void _fetchPlaceList() async {
    var owner = _firebaseAuth.currentUser.email;

    FirebaseFirestore.instance
        .collection(PATH_PLACE_DATA)
        .where('owner', isEqualTo: owner)
        .snapshots(includeMetadataChanges: true)
        .listen((querySnapshot) {
      placeList.clear();
      querySnapshot.docs.forEach((element) {
        print(element.data());
        PlaceData placeData = PlaceData();
        placeData.fromJSON(element.data());
        placeList.add(placeData);
      });
    });
  }
}

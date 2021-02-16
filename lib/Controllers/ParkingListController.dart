import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:parking_slot/Data/Models/ParkingData.dart';
import 'package:parking_slot/Resources/strings.dart';

class ParkingListController extends GetxController {
  FirebaseAuth _firebaseAuth;
  var parkingList = List<ParkingData>();

  @override
  void onInit() {
    super.onInit();
    _firebaseAuth = FirebaseAuth.instance;
    // fetchList();
  }

  Future<List<ParkingData>> fetchList() async {
    var values = await FirebaseFirestore.instance
        .collection(PATH_PARKING_DATA)
        .where('carOwner', isEqualTo: _firebaseAuth.currentUser.email.trim())
        .orderBy('id', descending: true)
        .get();

    parkingList.clear();

    values.docs.forEach((element) {
      var parkingData = ParkingData();
      parkingData.fromJSON(element.data());
      print("Parking data: " + parkingData.carLicense);
      parkingList.add(parkingData);
    });

    return parkingList;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:parking_slot/Data/Models/ParkingData.dart';
import 'package:parking_slot/Resources/strings.dart';

class ParkingListController extends GetxController {
  FirebaseAuth _firebaseAuth;
  var parkingList = List<ParkingData>().obs;

  @override
  void onInit() {
    super.onInit();
    _firebaseAuth = FirebaseAuth.instance;
    fetchList();
  }

  void fetchList() async {
    FirebaseFirestore.instance
        .collection(PATH_PARKING_DATA)
        .where('carOwner', isEqualTo: _firebaseAuth.currentUser.email.trim())
        .snapshots(includeMetadataChanges: true)
        .listen((event) {
      event.docs.forEach((element) {
        print("Parking: ${element.data()}");
        var parking = ParkingData();
        parking.fromJSON(element.data());
        parkingList.add(parking);
      });
    });
  }
}

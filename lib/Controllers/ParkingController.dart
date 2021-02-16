import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:parking_slot/Data/Models/ParkingData.dart';
import 'package:parking_slot/Data/Models/PlacesData.dart';
import 'package:parking_slot/Data/Models/UserData.dart';
import 'package:parking_slot/Resources/strings.dart';

class ParkingController extends GetxController {
  FirebaseAuth _firebaseAuth;
  @override
  void onInit() {
    super.onInit();
    _firebaseAuth = FirebaseAuth.instance;
  }

  Future<bool> bookSlot(id, PlaceData placeData, UserData userData) async {
    try {
      // var day = DateTime.now().day;
      // var month = DateTime.now().month;
      // var year = DateTime.now().year;
      // var hour = DateTime.now().hour;
      // var minutes = DateTime.now().minute;
      var startTime = "Date: --/--/--, Time: --:--";
      var endTime = "Date: --/--/--, Time: --:--";
      var startTimeInMilli = 0;
      var endTimeInMilli = 0;

      ParkingData parkingData = ParkingData(
          id: id,
          placeId: placeData.id,
          imageUrl: placeData.imageUrl,
          address: placeData.address,
          rate: placeData.rate,
          parkOwner: placeData.owner.toString().trim(),
          carOwner: _firebaseAuth.currentUser.email.trim(),
          carLicense: userData.license,
          parkOwnerNumber: placeData.phoneNumber,
          carOwnerNumber: userData.phoneNumber,
          startTime: startTime,
          endTime: endTime,
          startTimeInMilli: startTimeInMilli,
          endTimeInMilli: endTimeInMilli,
          status: 0);

      await FirebaseFirestore.instance
          .collection(PATH_PARKING_DATA)
          .doc(parkingData.id.toString())
          .set(parkingData.toJSON());

      return true;
    } catch (error) {
      print("ParkingDataUploadingError: $error");
      return false;
    }
  }
}

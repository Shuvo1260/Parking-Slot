import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parking_slot/Resources/strings.dart';

class BookingManager {
  static Future<bool> cancelBooking(id) async {
    try {
      await FirebaseFirestore.instance
          .collection(PATH_PARKING_DATA)
          .doc(id)
          .delete();
      return true;
    } catch (error) {
      print("BookingCancelError: $error");
      return false;
    }
  }
}

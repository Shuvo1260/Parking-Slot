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

  static Future<bool> updateBooking(String id, int status, int startTime,
      int endTime, String start, String end, String placeId) async {
    try {
      await FirebaseFirestore.instance
          .collection(PATH_PARKING_DATA)
          .doc(id)
          .update({
        'status': status,
        'startTimeInMilli': startTime,
        'endTimeInMilli': endTime,
        'startTime': start,
        'endTime': end
      });

      if (status == 2) {
        await FirebaseFirestore.instance
            .collection(PATH_PLACE_DATA)
            .doc(placeId)
            .update({
          'totalSlot': FieldValue.increment(-1),
          'parkedSlot': FieldValue.increment(1)
        });
      } else if (status == 3) {
        await FirebaseFirestore.instance
            .collection(PATH_PLACE_DATA)
            .doc(placeId)
            .update({
          'totalSlot': FieldValue.increment(1),
          'parkedSlot': FieldValue.increment(-1)
        });
      }
      return true;
    } catch (error) {
      print("UpdateBookingError: $error");
      return false;
    }
  }
}

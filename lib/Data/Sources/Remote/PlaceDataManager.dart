import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:parking_slot/Data/Models/PlacesData.dart';
import 'package:parking_slot/Resources/strings.dart';

class PlaceDataManager {
  static Future<bool> saveData(PlaceData placeData) async {
    try {
      await FirebaseFirestore.instance
          .collection(PATH_PLACE_DATA)
          .doc(placeData.id)
          .set(placeData.toJSON());
      return true;
    } catch (error) {
      print("PlaceDataSavingError: $error");
      return false;
    }
  }

  static Future<String> uploadFile(String imageUrl, id) async {
    try {
      File file = File(imageUrl);
      var result = await FirebaseStorage.instance
          .ref(PATH_PLACE_IMAGE + id)
          .putFile(file);
      return await result.ref.getDownloadURL();
    } catch (error) {
      print("FileUploadingError: $error");
      return null;
    }
  }

  static Future<PlaceData> getData() async {
    //
  }

  static Future<bool> deleteData(id) async {
    try {
      await FirebaseFirestore.instance
          .collection(PATH_PLACE_DATA)
          .doc(id)
          .delete();
      return true;
    } catch (error) {
      print("DeletingPlaceDataError: $error");
      return false;
    }
  }
}

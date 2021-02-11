import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:parking_slot/Data/Models/UserData.dart';
import 'package:parking_slot/Data/Sources/Remote/UserDataManager.dart';
import 'package:parking_slot/Utils/AppManager.dart';

class UserController extends GetxController {
  var userData = UserData().obs;
  FirebaseAuth _firebaseAuth;
  String _id;
  @override
  void onInit() {
    super.onInit();
    _firebaseAuth = FirebaseAuth.instance;
    _id = AppManager.emailToID(_firebaseAuth.currentUser.email);
    fetchUserData();
  }

  void fetchUserData() async {
    print("id: $_id");
    userData.value = await UserDataManager.getUserData(_id);
  }
}

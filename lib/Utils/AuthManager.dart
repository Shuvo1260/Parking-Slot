import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:parking_slot/Data/Models/UserData.dart';
import 'package:parking_slot/Data/Sources/Remote/UserDataManager.dart';
import 'package:parking_slot/Resources/strings.dart';

class AuthManager {
  FirebaseFirestore _firestore;
  FirebaseAuth _firebaseAuth;
  AuthManager() {
    _firestore = FirebaseFirestore.instance;
    _firebaseAuth = FirebaseAuth.instance;
  }

  Future<bool> isUserExist(String id) async {
    var value = await _firestore.collection(PATH_USER_DATA).doc(id).get();
    print("IsExist: ${value.exists}");
    return value.exists;
  }

  Future<bool> signUP(UserData userData) async {
    try {
      var value = await _firebaseAuth.createUserWithEmailAndPassword(
          email: userData.email.trim(), password: userData.password);
      if (value.user != null) {
        await value.user.sendEmailVerification();
        return await UserDataManager.saveUserData(userData);
      }
    } catch (error) {
      print("SignUpError: $error");
    }
    return false;
  }

  Future<String> signIn(email, password) async {
    try {
      var value = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.toString().trim(),
        password: password,
      );
      print("SignIn: ${value.user}");
      if (value.user != null) {
        return "Success";
      } else {
        return "Sign in failed";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return "User not found";
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return "Wrong password";
      }
    } catch (error) {
      print("SignInError: $error");
      return error.toString();
    }
  }
}

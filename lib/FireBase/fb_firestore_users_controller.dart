import 'package:Rehlati/models/user.dart';
import 'package:Rehlati/preferences/shared_preferences_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FbFireStoreUsersController {
  final FirebaseFirestore _firebaseFireStoreUsers = FirebaseFirestore.instance;

  // CRUD

  Future<bool> createUser({
    required UserModel user,
  }) async {
    return _firebaseFireStoreUsers
        .collection('users')
        .doc(user.uId)
        .set(user.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> updateFcmToken({
    required String uId,
    required String fcm,
  }) async {
    return _firebaseFireStoreUsers
        .collection('users')
        .doc(uId)
        .update({
          'fcmToken': fcm,
        })
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<int> getUserBalance({
    required String uId,
  }) async {
    int balance = 0;

    return _firebaseFireStoreUsers
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      if (value.exists) {
        balance = value.get('balance');
      }
      return balance;
    }).catchError((onError) {});
  }

  Future<bool> updateBalance({
    required String uId,
    required int balance,
  }) async {
    return _firebaseFireStoreUsers
        .collection('users')
        .doc(uId)
        .update({
          'balance': balance,
        })
        .then((value) => true)
        .catchError((error) => false);
  }
}

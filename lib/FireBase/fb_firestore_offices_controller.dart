import 'package:Rehlati/models/office.dart';
import 'package:Rehlati/preferences/shared_preferences_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FbFireStoreOfficesController {
  final FirebaseFirestore _firebaseFireStoreUsers = FirebaseFirestore.instance;

  // CRUD

  Future<bool> createOffice({
    required OfficeModel office,
  }) async {
    return _firebaseFireStoreUsers
        .collection('offices')
        .doc(office.uId)
        .set(office.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<bool> updateFcmToken({
    required String uId,
    required String fcm,
  }) async {
    return _firebaseFireStoreUsers
        .collection('offices')
        .doc(uId)
        .update({
          'fcmToken': fcm,
        })
        .then((value) => true)
        .catchError((error) => false);
  }

  Future<int> getOfficeBalance({
    required String uId,
  }) async {
    int balance = 0;

    return _firebaseFireStoreUsers
        .collection('offices')
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
        .collection('offices')
        .doc(uId)
        .update({
          'balance': balance,
        })
        .then((value) => true)
        .catchError((error) => false);
  }

  // Updating Trip

  Future<List<String>> getFcmTokensForTrip({
    required String tripId,
  }) async {
    // Get Users Ids

    List<String> usersIds = <String>[];

    var docsWhereTripId = await _firebaseFireStoreUsers
        .collection('offices')
        .doc(SharedPrefController().getUId)
        .collection('orders')
        .where('tripId', isEqualTo: tripId)
        .get();
    var listWhereTripId = docsWhereTripId.docs;

    for (int i = 0; i < listWhereTripId.length; i++) {
      int index = usersIds
          .indexWhere((element) => element == listWhereTripId[i].get('userId'));
      if (index == -1) {
        usersIds.add(listWhereTripId[i].get('userId'));
      }
    }

    // Get Users Fcm Tokens

    List<String> usersFcmTokens = <String>[];

    for (int i = 0; i < usersIds.length; i++) {
      var docWithUserId = await _firebaseFireStoreUsers
          .collection('users')
          .doc(usersIds[i])
          .get();

      var fcmToken = docWithUserId.get('fcmToken');

      usersFcmTokens.add(fcmToken);
    }

    return usersFcmTokens;
  }
}

import 'package:Rehlati/models/notification.dart';
import 'package:Rehlati/preferences/shared_preferences_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FbFireStoreNotificationsController {
  final FirebaseFirestore _firebaseFireStoreUsers = FirebaseFirestore.instance;

  // CRUD

  Future<void> addNotificationToUsers({
    required String tripId,
    required NotificationModel notification,
  }) async {
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

    for (int i = 0; i < usersIds.length; i++) {
      await _firebaseFireStoreUsers
          .collection('users')
          .doc(usersIds[i])
          .collection('notifications')
          .doc(notification.notificationId)
          .set(notification.toMap());
    }
  }

  Stream<QuerySnapshot> readNotificationsForUser() async* {
    yield* _firebaseFireStoreUsers
        .collection('users')
        .doc(SharedPrefController().getUId)
        .collection('notifications')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}

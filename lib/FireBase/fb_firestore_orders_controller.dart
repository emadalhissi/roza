import 'package:Rehlati/models/order.dart';
import 'package:Rehlati/preferences/shared_preferences_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FbFireStoreOrdersController {
  final FirebaseFirestore _firebaseFireStoreUsers = FirebaseFirestore.instance;

  Stream<QuerySnapshot> readUserReservations() async* {
    yield* _firebaseFireStoreUsers
        .collection('users')
        .doc(SharedPrefController().getUId)
        .collection('orders')
        .snapshots();
  }

  Stream<QuerySnapshot> readOfficeOrders() async* {
    yield* _firebaseFireStoreUsers
        .collection('offices')
        .doc(SharedPrefController().getUId)
        .collection('orders')
        .snapshots();
  }

  Stream<QuerySnapshot> readAllReservationsForAdmin() async* {
    yield* _firebaseFireStoreUsers.collection('orders').snapshots();
  }

  Future<void> createOrder({required Order order}) async {
    await _firebaseFireStoreUsers
        .collection('users')
        .doc(SharedPrefController().getUId)
        .collection('orders')
        .doc(order.orderId)
        .set(order.toMap());

    await _firebaseFireStoreUsers
        .collection('offices')
        .doc(order.officeId)
        .collection('orders')
        .doc(order.orderId)
        .set(order.toMap());

    await _firebaseFireStoreUsers
        .collection('offices')
        .doc(order.officeId)
        .collection('trips')
        .doc(order.tripId)
        .collection('orders')
        .doc(order.orderId)
        .set(order.toMap());

    await _firebaseFireStoreUsers
        .collection('cities')
        .doc(order.addressCityName)
        .collection('trips')
        .doc(order.tripId)
        .collection('orders')
        .doc(order.orderId)
        .set(order.toMap());

    await _firebaseFireStoreUsers
        .collection('orders')
        .doc(order.orderId)
        .set(order.toMap());
  }

  Future<void> changeOrderStatus({
    required String status,
    required String userId,
    required String orderId,
    required String officeId,
    required String tripId,
    required String city,
  }) async {
    await _firebaseFireStoreUsers
        .collection('users')
        .doc(userId)
        .collection('orders')
        .doc(orderId)
        .update({
      'status': status,
    });

    await _firebaseFireStoreUsers
        .collection('offices')
        .doc(officeId)
        .collection('orders')
        .doc(orderId)
        .update({
      'status': status,
    });

    await _firebaseFireStoreUsers
        .collection('offices')
        .doc(officeId)
        .collection('trips')
        .doc(tripId)
        .collection('orders')
        .doc(orderId)
        .update({
      'status': status,
    });

    await _firebaseFireStoreUsers
        .collection('cities')
        .doc(city)
        .collection('trips')
        .doc(tripId)
        .collection('orders')
        .doc(orderId)
        .update({
      'status': status,
    });

    await _firebaseFireStoreUsers.collection('orders').doc(orderId).update({
      'status': status,
    });
  }
}

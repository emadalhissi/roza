import 'package:Rehlati/models/trip.dart';
import 'package:Rehlati/preferences/shared_preferences_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FbFireStoreTripsController {
  final FirebaseFirestore _firebaseFireStoreUsers = FirebaseFirestore.instance;

  Stream<QuerySnapshot> readMyTrips() async* {
    yield* _firebaseFireStoreUsers
        .collection('offices')
        .doc(SharedPrefController().getUId)
        .collection('trips')
        .snapshots();
  }

  Stream<QuerySnapshot> readTrips(String city) async* {
    yield* _firebaseFireStoreUsers
        .collection('cities')
        .doc(city)
        .collection('trips')
        .snapshots();
  }

  Future<void> createTrip({required Trip trip}) async {
    await _firebaseFireStoreUsers
        .collection('offices')
        .doc(SharedPrefController().getUId)
        .collection('trips')
        .doc(trip.tripId)
        .set(trip.toMap());

    await _firebaseFireStoreUsers
        .collection('cities')
        .doc(trip.addressCityName)
        .collection('trips')
        .doc(trip.tripId)
        .set(trip.toMap());
  }

  Future<void> editTrip({
    required Trip trip,
  }) async {
    await _firebaseFireStoreUsers
        .collection('offices')
        .doc(SharedPrefController().getUId)
        .collection('trips')
        .doc(trip.tripId)
        .update(trip.toMap());

    await _firebaseFireStoreUsers
        .collection('cities')
        .doc(trip.addressCityName)
        .collection('trips')
        .doc(trip.tripId)
        .update(trip.toMap());
  }

  Future<void> deleteTrip({
    required String tripId,
    required String tripCity,
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

    // Delete Trip

    await _firebaseFireStoreUsers
        .collection('offices')
        .doc(SharedPrefController().getUId)
        .collection('trips')
        .doc(tripId)
        .delete();

    await _firebaseFireStoreUsers
        .collection('cities')
        .doc(tripCity)
        .collection('trips')
        .doc(tripId)
        .delete();

    // Delete Orders Belongs to the Trip

    var docsWhereOrderIdInOfficeCollection = await _firebaseFireStoreUsers
        .collection('offices')
        .doc(SharedPrefController().getUId)
        .collection('orders')
        .where('tripId', isEqualTo: tripId)
        .get();

    var listWhereOrderIdInOfficeCollection =
        docsWhereOrderIdInOfficeCollection.docs;

    for (int i = 0; i < listWhereOrderIdInOfficeCollection.length; i++) {
      await _firebaseFireStoreUsers
          .collection('offices')
          .doc(SharedPrefController().getUId)
          .collection('orders')
          .doc(listWhereOrderIdInOfficeCollection[i].id)
          .delete();

      await _firebaseFireStoreUsers
          .collection('orders')
          .doc(listWhereOrderIdInOfficeCollection[i].id)
          .delete();
    }

    for (int i = 0; i < usersIds.length; i++) {
      for (int j = 0; j < listWhereOrderIdInOfficeCollection.length; j++) {
        await _firebaseFireStoreUsers
            .collection('users')
            .doc(usersIds[i])
            .collection('orders')
            .doc(listWhereOrderIdInOfficeCollection[j].id)
            .delete();
      }
      await _firebaseFireStoreUsers
          .collection('users')
          .doc(usersIds[i])
          .collection('favorites')
          .doc(tripId)
          .delete();
    }

    var offices = await _firebaseFireStoreUsers.collection('offices').get();
    var officesList = offices.docs;

    for (int i = 0; i < officesList.length; i++) {
      await _firebaseFireStoreUsers
          .collection('offices')
          .doc(officesList[i].id)
          .collection('favorites')
          .doc(tripId)
          .delete();
    }
  }

  Future<void> deleteTripImage({
    required String tripId,
    required String tripCity,
    required String imageUrl,
  }) async {
    await _firebaseFireStoreUsers
        .collection('offices')
        .doc(SharedPrefController().getUId)
        .collection('trips')
        .doc(tripId)
        .update({
          'images': FieldValue.arrayRemove([imageUrl])
        })
        .then((value) {})
        .catchError((error) {});

    await _firebaseFireStoreUsers
        .collection('cities')
        .doc(tripCity)
        .collection('trips')
        .doc(tripId)
        .update({
          'images': FieldValue.arrayRemove([imageUrl])
        })
        .then((value) {})
        .catchError((error) {});
  }

  Future<void> updateTripSpace({
    required String officeUId,
    required String tripId,
    required String newSpace,
    required String addressCityName,
  }) async {
    await _firebaseFireStoreUsers
        .collection('offices')
        .doc(officeUId)
        .collection('trips')
        .doc(tripId)
        .update({
      'space': newSpace,
    });

    await _firebaseFireStoreUsers
        .collection('cities')
        .doc(addressCityName)
        .collection('trips')
        .doc(tripId)
        .update({
      'space': newSpace,
    });
  }
}

import 'package:Rehlati/models/office.dart';
import 'package:Rehlati/models/trip.dart';
import 'package:Rehlati/models/user.dart';
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
}

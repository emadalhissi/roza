import 'package:Rehlati/models/office.dart';
import 'package:Rehlati/models/trip.dart';
import 'package:Rehlati/models/user.dart';
import 'package:Rehlati/preferences/shared_preferences_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FbFireStoreTripsController {
  final FirebaseFirestore _firebaseFireStoreUsers = FirebaseFirestore.instance;

  Future<bool> createTripInOffice({required Trip trip}) async {
    return _firebaseFireStoreUsers
        .collection('offices')
        .doc(SharedPrefController().getUId)
        .collection('trips')
        .doc(trip.tripId)
        .set(trip.toMap())
        .then((value) => true)
        .catchError((onError) => false);
  }

  Future<bool> createTripInCity({required Trip trip}) async {
    return _firebaseFireStoreUsers
        .collection('cities')
        .doc(trip.addressCity)
        .collection('trips')
        .doc(trip.tripId)
        .set(trip.toMap())
        .then((value) => true)
        .catchError((onError) => false);
  }
}

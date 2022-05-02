import 'package:Rehlati/models/trip.dart';
import 'package:Rehlati/preferences/shared_preferences_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

typedef CallBackUrl = void Function({
  required bool status,
  required bool favorite,
  required Trip trip,
});

class FbFireStoreFavoritesController {
  final FirebaseFirestore _firebaseFireStoreUsers = FirebaseFirestore.instance;

  Future<List<Trip>> readFavorites({
    required String type,
  }) async {
    List<Trip> favorites = [];
    var favorites_ = await FirebaseFirestore.instance
        .collection('${type}s')
        .doc(SharedPrefController().getUId)
        .collection('favorites')
        .get();

    if (favorites_.docs.isNotEmpty) {
      for (var doc in favorites_.docs) {
        favorites.add(Trip.fromMap(doc.data()));
      }
      return favorites;
    }

    return [];
  }

  Future<void> favorite({
    required String tripId,
    required String officeId,
    required String type,
    required CallBackUrl callBackUrl,
  }) async {
    late Trip trip;
    var trip_ = await FirebaseFirestore.instance
        .collection('offices')
        .doc(officeId)
        .collection('trips')
        .doc(tripId)
        .get();

    if (trip_.exists) {
      trip = Trip.fromMap(trip_.data()!);
    }

    var checkFavorite = await FirebaseFirestore.instance
        .collection('${type}s')
        .doc(SharedPrefController().getUId)
        .collection('favorites')
        .doc(tripId)
        .get();

    if (!checkFavorite.exists) {
      await _firebaseFireStoreUsers
          .collection('${type}s')
          .doc(SharedPrefController().getUId)
          .collection('favorites')
          .doc(tripId)
          .set(trip.toMap())
          .then((value) {
        callBackUrl(
          status: true,
          favorite: true,
          trip: trip,
        );
      }).catchError((onError) {
        callBackUrl(
          status: false,
          favorite: false,
          trip: trip,
        );
      });
    } else {
      await _firebaseFireStoreUsers
          .collection('${type}s')
          .doc(SharedPrefController().getUId)
          .collection('favorites')
          .doc(tripId)
          .delete()
          .then((value) {
        callBackUrl(
          status: true,
          favorite: false,
          trip: trip,
        );
      }).catchError((onError) {
        callBackUrl(
          status: false,
          favorite: true,
          trip: trip,
        );
      });
    }
  }
}

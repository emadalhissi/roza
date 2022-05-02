import 'package:Rehlati/models/trip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoritesProvider extends ChangeNotifier {
  List<Trip> favorites_ = <Trip>[];

  Future<void> storeFavorites_({
    required List<Trip> favorites,
  }) async {
    favorites_ = favorites;
    notifyListeners();
  }

  void favorite_({
    required Trip trip,
    required bool status,
  }) {
    if (status) {
      favorites_.add(trip);
    } else {
      favorites_.removeWhere((element) => element.tripId == trip.tripId);
    }
    notifyListeners();
  }

  bool checkFavorite({
    required String tripId,
  }) {
    int index = favorites_.indexWhere((element) => element.tripId == tripId);
    return index != -1;
  }
}

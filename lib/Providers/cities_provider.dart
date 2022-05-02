import 'package:Rehlati/models/city.dart';
import 'package:Rehlati/models/trip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CitiesProvider extends ChangeNotifier {
  List<Trip> shownTrips = <Trip>[];

  List<City> citiesList = <City>[];

  void changeCitiesList({required List<City> city}) {
    citiesList = city;
    notifyListeners();
  }

  void changeSelectedCity({required String city}) {
    // selectedCity = city;
    notifyListeners();
  }

  void changeShownTrips({required List<Trip> list}) {
    shownTrips = list;
    notifyListeners();
  }
}

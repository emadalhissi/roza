import 'package:Rehlati/models/city.dart';
import 'package:Rehlati/models/trip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CitiesProvider extends ChangeNotifier {
  List<City> citiesList = <City>[];

  void changeCitiesList({
    required List<City> city,
  }) {
    citiesList = city;
    notifyListeners();
  }
}

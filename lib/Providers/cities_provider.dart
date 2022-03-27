import 'package:Rehlati/models/city.dart';
import 'package:Rehlati/models/trip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Rehlati/preferences/shared_preferences_controller.dart';

class CitiesProvider extends ChangeNotifier {
  List<Trip> shownTrips = <Trip>[
    // Trip(
    //   image: 'https://images.pexels.com/photos/210186/pexels-photo-210186.jpeg',
    //   name: 'TEST Trip',
    //   time: '12:30',
    //   date: '2022-03-09',
    //   addressCity: 'Trip 1 address',
    //   price: '500',
    //   city: 'Hebron',
    //   noOfOrders: '4',
    // ),
  ];

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

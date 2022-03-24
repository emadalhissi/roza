import 'package:Rehlati/models/trip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Rehlati/preferences/shared_preferences_controller.dart';

class TripProvider extends ChangeNotifier {
  List<Trip> shownTrips = <Trip>[
    Trip(
      image: 'https://images.pexels.com/photos/210186/pexels-photo-210186.jpeg',
      name: 'TEST Trip',
      time: '12:30',
      date: '2022-03-09',
      address: 'Trip 1 address',
      price: '500',
      rate: '4.2',
      favorite: false,
      city: 'Hebron',
      noOfOrders: '4',
    ),
  ];

  void changeSelectedCity({required String city}) {
    // selectedCity = city;
    notifyListeners();
  }

  void changeShownTrips({required List<Trip> list}) {
    shownTrips = list;
    notifyListeners();
  }
}

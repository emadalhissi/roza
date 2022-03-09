import 'package:Rehlati/models/trip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Rehlati/preferences/shared_preferences_controller.dart';

class TripProvider extends ChangeNotifier {

  String selectedCity = 'All';
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
    ),
  ];
  List<Trip> tripsList = <Trip>[
    Trip(
      image: 'https://images.pexels.com/photos/210186/pexels-photo-210186.jpeg',
      name: 'Trip 1 name',
      time: '12:30',
      date: '2022-03-09',
      address: 'Trip 1 address',
      price: '500',
      rate: '4.2',
      favorite: false,
      city: 'Hebron',
    ),
    Trip(
      image:
      'https://webneel.com/wallpaper/sites/default/files/images/08-2018/3-nature-wallpaper-mountain.jpg',
      name: 'Trip 2 name',
      time: '12:30',
      date: '2022-03-09',
      address: 'Trip 2 address',
      price: '299',
      rate: '4.9',
      favorite: false,
      city: 'Ramallah',
    ),
    Trip(
      image:
      'https://i.pinimg.com/originals/15/f6/a3/15f6a3aac562ee0fadbbad3d4cdf47bc.jpg',
      name: 'Trip 3 name',
      time: '12:30',
      date: '2022-03-09',
      address: 'Trip 3 address',
      price: '152',
      rate: '5',
      favorite: false,
      city: 'Jericho',
    ),
  ];

  void changeSelectedCity({required String city}) {
    selectedCity = city;
    notifyListeners();
  }

  void changeShownTrips({required List<Trip> list}) {
    shownTrips = list;
    notifyListeners();
  }

}
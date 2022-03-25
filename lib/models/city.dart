import 'package:Rehlati/models/trip.dart';

class City {
  late int id;
  late String name;

  // late List<Trip> trips;

  City.fromMap(Map<String, dynamic> documentMap) {
    id = documentMap['id'];
    name = documentMap['name'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}

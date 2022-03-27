import 'package:Rehlati/models/trip.dart';

class City {
  late int id;
  late String name;
  late List<Trip>? trips;

  City();

  City.fromMap(Map<String, dynamic> documentMap) {
    id = documentMap['id'];
    name = documentMap['name'];
    if (documentMap['trips'] != null) {
      trips = <Trip>[];
      documentMap['trips'].forEach((v) {
        trips!.add(Trip.fromMap(v));
      });
    }
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    if (trips != null) {
      map['trips'] = trips!.map((v) => v.toMap()).toList();
    }
    return map;
  }
}

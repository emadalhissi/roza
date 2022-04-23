import 'package:Rehlati/models/trip.dart';

class City {
  late int id;
  late String name;
  late String nameAr;
  late List<Trip>? trips;

  City({
    required this.id,
    required this.name,
    required this.nameAr,
  });

  City.fromMap(Map<String, dynamic> documentMap) {
    id = documentMap['id'];
    name = documentMap['name'];
    nameAr = documentMap['nameAr'];
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
    map['nameAr'] = nameAr;
    if (trips != null) {
      map['trips'] = trips!.map((v) => v.toMap()).toList();
    }
    return map;
  }
}

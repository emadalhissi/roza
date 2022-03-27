import 'package:Rehlati/models/order.dart';
import 'package:Rehlati/models/trip.dart';

class OfficeModel {
  late String uId;
  late String name;
  late String mobile;
  late String email;
  late String type;
  late String profileImage;
  late List<Trip>? trips;
  late List<Order>? orders;

  OfficeModel();

  OfficeModel.fromMap(Map<String, dynamic> documentMap) {
    uId = documentMap['uId'];
    email = documentMap['email'];
    name = documentMap['name'];
    mobile = documentMap['mobile'];
    type = documentMap['type'];
    profileImage = documentMap['profileImage'];
    if (documentMap['trips'] != null) {
      trips = <Trip>[];
      documentMap['trips'].forEach((v) {
        trips!.add(Trip.fromMap(v));
      });
    }
    if (documentMap['orders'] != null) {
      orders = <Order>[];
      documentMap['orders'].forEach((v) {
        orders!.add(Order.fromMap(v));
      });
    }
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['uId'] = uId;
    map['email'] = email;
    map['name'] = name;
    map['mobile'] = mobile;
    map['type'] = type;
    map['profileImage'] = profileImage;
    if (trips != null) {
      map['trips'] = trips!.map((v) => v.toMap()).toList();
    }
    if (orders != null) {
      map['orders'] = orders!.map((v) => v.toMap()).toList();
    }
    return map;
  }
}

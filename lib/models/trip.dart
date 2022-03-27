import 'package:Rehlati/models/image.dart';
import 'package:Rehlati/models/order.dart';

class Trip {
  late String? tripId;
  late String name;
  late String description;
  late String time;
  late String date;
  late String addressCity;
  late String price;
  late String minPayment;
  late List<Order>? orders;
  late List<String>? images;
  // late List<ImageModel>? images;

  Trip({
    required this.tripId,
    required this.name,
    required this.description,
    required this.time,
    required this.date,
    required this.addressCity,
    required this.price,
    required this.minPayment,
    this.orders,
    this.images,
  });

  Trip.fromMap(Map<String, dynamic> json) {
    tripId = json['tripId'];
    name = json['name'];
    description = json['description'];
    time = json['time'];
    date = json['date'];
    addressCity = json['addressCity'];
    price = json['price'];
    minPayment = json['minPayment'];
    if (json['orders'] != null) {
      orders = <Order>[];
      json['orders'].forEach((v) {
        orders!.add(Order.fromMap(v));
      });
    }
    if (json['images'] != null) {
      images = <String>[];
      json['images'].forEach((v) {
        images!.add(v);
      });
    }
    // if (json['images'] != null) {
    //   images = <ImageModel>[];
    //   json['images'].forEach((v) {
    //     images!.add(ImageModel.fromMap(v));
    //   });
    // }
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tripId'] = tripId;
    data['name'] = name;
    data['description'] = description;
    data['time'] = time;
    data['date'] = date;
    data['addressCity'] = addressCity;
    data['price'] = price;
    data['minPayment'] = minPayment;
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toMap()).toList();
    }
    if (images != null) {
      data['images'] = images!.map((v) => v).toList();
    }
    // if (images != null) {
    //   data['images'] = images!.map((v) => v.toMap()).toList();
    // }
    return data;
  }
}

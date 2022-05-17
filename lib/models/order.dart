class Order {
  late String? orderId;
  late String? orderTime;
  late String? orderDate;
  late String? tripId;
  late String? tripImage;
  late String? tripName;
  late String? tripTime;
  late String? tripDate;
  late String? officeId;
  late String? officeName;
  late String? officeEmail;
  late int? cityId;
  late String? addressCityName;
  late String? addressCityNameAr;
  late String? status;
  late String? officeNote;
  late String? userNote;
  late String? noOfPeople;
  late int? firstPayment;
  late int? leftPayment;
  late bool? fullPaid;
  late String? userId;
  late String? userName;
  late String? userMobile;
  late String? userDocId;
  late String? userEmail;
  late int? userAge;
  late int? userGender;

  Order({
    required this.orderId,
    required this.orderTime,
    required this.orderDate,
    required this.tripId,
    required this.tripTime,
    required this.tripDate,
    required this.tripImage,
    required this.tripName,
    required this.officeId,
    required this.officeName,
    required this.officeEmail,
    required this.cityId,
    required this.addressCityName,
    required this.addressCityNameAr,
    required this.status,
    required this.officeNote,
    required this.userNote,
    required this.noOfPeople,
    required this.firstPayment,
    required this.leftPayment,
    required this.fullPaid,
    required this.userId,
    required this.userName,
    required this.userMobile,
    required this.userDocId,
    required this.userEmail,
    required this.userAge,
    required this.userGender,
  });

  Order.fromMap(Map<String, dynamic> json) {
    orderId = json['orderId'];
    orderTime = json['orderTime'];
    orderDate = json['orderDate'];
    tripId = json['tripId'];
    tripTime = json['tripTime'];
    tripDate = json['tripDate'];
    tripImage = json['tripImage'];
    tripName = json['tripName'];
    officeId = json['officeId'];
    officeName = json['officeName'];
    officeEmail = json['officeEmail'];
    cityId = json['cityId'];
    addressCityName = json['addressCityName'];
    addressCityNameAr = json['addressCityNameAr'];
    status = json['status'];
    officeNote = json['officeNote'];
    userNote = json['userNote'];
    noOfPeople = json['noOfPeople'];
    firstPayment = json['firstPayment'];
    leftPayment = json['leftPayment'];
    fullPaid = json['fullPaid'];
    userId = json['userId'];
    userName = json['userName'];
    userMobile = json['userMobile'];
    userDocId = json['userDocId'];
    userEmail = json['userEmail'];
    userAge = json['userAge'];
    userGender = json['userGender'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderId'] = orderId;
    data['orderTime'] = orderTime;
    data['orderDate'] = orderDate;
    data['tripId'] = tripId;
    data['tripTime'] = tripTime;
    data['tripDate'] = tripDate;
    data['tripImage'] = tripImage;
    data['tripName'] = tripName;
    data['officeId'] = officeId;
    data['officeName'] = officeName;
    data['officeEmail'] = officeEmail;
    data['cityId'] = cityId;
    data['addressCityName'] = addressCityName;
    data['addressCityNameAr'] = addressCityNameAr;
    data['status'] = status;
    data['officeNote'] = officeNote;
    data['userNote'] = userNote;
    data['noOfPeople'] = noOfPeople;
    data['firstPayment'] = firstPayment;
    data['leftPayment'] = leftPayment;
    data['fullPaid'] = fullPaid;
    data['userId'] = userId;
    data['userName'] = userName;
    data['userMobile'] = userMobile;
    data['userDocId'] = userDocId;
    data['userEmail'] = userEmail;
    data['userAge'] = userAge;
    data['userGender'] = userGender;
    return data;
  }
}

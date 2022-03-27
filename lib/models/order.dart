class Order {
  late String orderId;
  late String orderTime;
  late String orderDate;
  late String tripId;
  late String officeId;
  late String cityId;
  late String status;
  late String officeNote;
  late String userNote;
  late int noOfPeople;
  late int firstPayment;
  late int leftPayment;
  late bool fullPaid;
  late String userName;
  late String userMobile;
  late String userDocId;

  Order();

  Order.fromMap(Map<String, dynamic> json) {
    orderId = json['orderId'];
    orderTime = json['orderTime'];
    orderDate = json['orderDate'];
    tripId = json['tripId'];
    officeId = json['officeId'];
    cityId = json['cityId'];
    status = json['status'];
    officeNote = json['officeNote'];
    userNote = json['userNote'];
    noOfPeople = json['noOfPeople'];
    firstPayment = json['firstPayment'];
    leftPayment = json['leftPayment'];
    fullPaid = json['fullPaid'];
    userName = json['userName'];
    userMobile = json['userMobile'];
    userDocId = json['userDocId'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderId'] = orderId;
    data['orderTime'] = orderTime;
    data['orderDate'] = orderDate;
    data['tripId'] = tripId;
    data['officeId'] = officeId;
    data['cityId'] = cityId;
    data['status'] = status;
    data['officeNote'] = officeNote;
    data['userNote'] = userNote;
    data['noOfPeople'] = noOfPeople;
    data['firstPayment'] = firstPayment;
    data['leftPayment'] = leftPayment;
    data['fullPaid'] = fullPaid;
    data['userName'] = userName;
    data['userMobile'] = userMobile;
    data['userDocId'] = userDocId;
    return data;
  }
}

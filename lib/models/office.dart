
class OfficeModel {
  late String uId;
  late String name;
  late String mobile;
  late String email;
  late String type;
  late String profileImage;
  late String fcmToken;
  late int balance;

  OfficeModel();

  OfficeModel.fromMap(Map<String, dynamic> documentMap) {
    uId = documentMap['uId'];
    email = documentMap['email'];
    name = documentMap['name'];
    mobile = documentMap['mobile'];
    type = documentMap['type'];
    profileImage = documentMap['profileImage'];
    fcmToken = documentMap['fcmToken'];
    balance = documentMap['balance'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['uId'] = uId;
    map['email'] = email;
    map['name'] = name;
    map['mobile'] = mobile;
    map['type'] = type;
    map['profileImage'] = profileImage;
    map['fcmToken'] = fcmToken;
    map['balance'] = balance;
    return map;
  }
}

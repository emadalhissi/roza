class UserModel {
  late String uId;
  late String name;
  late String mobile;
  late String email;
  late String type;
  late String profileImage;

  UserModel();

  UserModel.fromMap(Map<String, dynamic> documentMap) {
    uId = documentMap['uId'];
    email = documentMap['email'];
    name = documentMap['name'];
    mobile = documentMap['mobile'];
    type = documentMap['type'];
    profileImage = documentMap['profileImage'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['uId'] = uId;
    map['email'] = email;
    map['name'] = name;
    map['mobile'] = mobile;
    map['type'] = type;
    map['profileImage'] = profileImage;
    return map;
  }
}

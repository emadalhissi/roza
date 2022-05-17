import 'package:shared_preferences/shared_preferences.dart';

enum SharedPrefKeys {
  loggedIn,
  fullName,
  email,
  mobile,
  lang,
  uId,
  accountType,
  profileImage,
  fcmToken,
}

class SharedPrefController {
  static final SharedPrefController _sharedPrefControllerObj =
      SharedPrefController._sharedPrefPrivateConstructor();

  late SharedPreferences _sharedPrefLibObj;

  SharedPrefController._sharedPrefPrivateConstructor();

  factory SharedPrefController() {
    return _sharedPrefControllerObj;
  }

  Future<void> initSharedPref() async {
    _sharedPrefLibObj = await SharedPreferences.getInstance();
  }

  Future<bool> login() async {
    return await _sharedPrefLibObj.setBool(
        SharedPrefKeys.loggedIn.toString(), true);
  }

  bool get checkLoggedIn =>
      _sharedPrefLibObj.getBool(SharedPrefKeys.loggedIn.toString()) ?? false;

  Future<bool> setFullName({required String name}) async {
    return await _sharedPrefLibObj.setString(
        SharedPrefKeys.fullName.toString(), name);
  }

  String get getFullName =>
      _sharedPrefLibObj.getString(SharedPrefKeys.fullName.toString()) ?? '';

  Future<bool> setEmail({required String email}) async {
    return await _sharedPrefLibObj.setString(
        SharedPrefKeys.email.toString(), email);
  }

  String get getEmail =>
      _sharedPrefLibObj.getString(SharedPrefKeys.email.toString()) ?? '';

  Future<bool> setMobile({required String mobile}) async {
    return await _sharedPrefLibObj.setString(
        SharedPrefKeys.mobile.toString(), mobile);
  }

  String get getMobile =>
      _sharedPrefLibObj.getString(SharedPrefKeys.mobile.toString()) ?? '';

  Future<bool> setUId({required String uId}) async {
    return await _sharedPrefLibObj.setString(
        SharedPrefKeys.uId.toString(), uId);
  }

  String get getUId =>
      _sharedPrefLibObj.getString(SharedPrefKeys.uId.toString()) ?? '';

  Future<bool> setAccountType({required String type}) async {
    return await _sharedPrefLibObj.setString(
        SharedPrefKeys.accountType.toString(), type);
  }

  String get getAccountType =>
      _sharedPrefLibObj.getString(SharedPrefKeys.accountType.toString()) ?? '';

  Future<bool> setProfileImage({required String image}) async {
    return await _sharedPrefLibObj.setString(
        SharedPrefKeys.profileImage.toString(), image);
  }

  String get getProfileImage =>
      _sharedPrefLibObj.getString(SharedPrefKeys.profileImage.toString()) ?? '';

  Future<bool> setFcmToken({required String fcm}) async {
    return await _sharedPrefLibObj.setString(
        SharedPrefKeys.fcmToken.toString(), fcm);
  }

  String get getFcmToken =>
      _sharedPrefLibObj.getString(SharedPrefKeys.fcmToken.toString()) ?? '';

  Future<void> logout() async {
    await _sharedPrefLibObj.setBool(SharedPrefKeys.loggedIn.toString(), false);
    await _sharedPrefLibObj.setString(SharedPrefKeys.fullName.toString(), '');
    await _sharedPrefLibObj.setString(SharedPrefKeys.email.toString(), '');
    await _sharedPrefLibObj.setString(SharedPrefKeys.mobile.toString(), '');
    await _sharedPrefLibObj.setString(SharedPrefKeys.uId.toString(), '');
    await _sharedPrefLibObj.setString(SharedPrefKeys.fcmToken.toString(), '');
    await _sharedPrefLibObj.setString(
        SharedPrefKeys.accountType.toString(), '');
    await _sharedPrefLibObj.setString(
        SharedPrefKeys.profileImage.toString(), '');
  }

  Future<bool> changeLang({required String lang}) async {
    return await _sharedPrefLibObj.setString(
        SharedPrefKeys.lang.toString(), lang);
  }

  String get getLang =>
      _sharedPrefLibObj.getString(SharedPrefKeys.lang.toString()) ?? 'en';
}

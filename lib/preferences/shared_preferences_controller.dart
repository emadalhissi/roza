// import 'package:api_ex/models/api_models/student_api_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SharedPrefKeys {
  loggedIn,
  fullName,
  email,
  lang,
  gender,
  token,
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

  Future<void> saveFullName({required String fullName}) async {
    await _sharedPrefLibObj.setString(
        SharedPrefKeys.fullName.toString(), fullName);
  }

  String get getFullName =>
      _sharedPrefLibObj.getString(SharedPrefKeys.fullName.toString()) ?? '';

  Future<void> saveEmail({required String email}) async {
    await _sharedPrefLibObj.setString(SharedPrefKeys.email.toString(), email);
  }

  bool get checkLoggedIn =>
      _sharedPrefLibObj.getBool(SharedPrefKeys.loggedIn.toString()) ?? false;

  String get getToken =>
      _sharedPrefLibObj.getString(SharedPrefKeys.token.toString()) ?? '';

  Future<bool> logout() async {
    return await _sharedPrefLibObj.setBool(
        SharedPrefKeys.loggedIn.toString(), false);
  }

  Future<bool> changeLang({required String lang}) async {
    return await _sharedPrefLibObj.setString(
        SharedPrefKeys.lang.toString(), lang);
  }

  String get getLang =>
      _sharedPrefLibObj.getString(SharedPrefKeys.lang.toString()) ?? 'en';
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Rehlati/preferences/shared_preferences_controller.dart';

class ProfileProvider extends ChangeNotifier {
  bool loggedIn_ = SharedPrefController().checkLoggedIn;
  String name_ = SharedPrefController().getFullName;
  String email_ = SharedPrefController().getEmail;
  String mobile_ = SharedPrefController().getMobile;
  String uId_ = SharedPrefController().getUId;
  String profileImage_ = SharedPrefController().getProfileImage;
  String accountType_ = SharedPrefController().getAccountType;
  String fcmToken_ = SharedPrefController().getFcmToken;

  void login_() {
    loggedIn_ = true;
    SharedPrefController().login();
    notifyListeners();
  }

  void setName_(String name) {
    name_ = name;
    SharedPrefController().setFullName(name: name);
    notifyListeners();
  }

  void setEmail_(String email) {
    email_ = email;
    SharedPrefController().setEmail(email: email);
    notifyListeners();
  }

  void setMobile_(String mobile) {
    mobile_ = mobile;
    SharedPrefController().setMobile(mobile: mobile);
    notifyListeners();
  }

  void setUserId_(String uId) {
    uId_ = uId;
    SharedPrefController().setUId(uId: uId);
    notifyListeners();
  }

  void setProfileImage_(String profileImage) {
    profileImage_ = profileImage;
    SharedPrefController().setProfileImage(image: profileImage);
    notifyListeners();
  }

  void setAccountType_(String accountType) {
    accountType_ = accountType;
    SharedPrefController().setAccountType(type: accountType);
    notifyListeners();
  }

  void setFcmToken_(String fcm) {
    fcmToken_ = fcm;
    SharedPrefController().setFcmToken(fcm: fcm);
    notifyListeners();
  }

  void logout() {
    loggedIn_ = false;
    SharedPrefController().logout();
    notifyListeners();
  }
}

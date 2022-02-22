import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Rehlati/preferences/shared_preferences_controller.dart';

class LangProvider extends ChangeNotifier {

  String lang = SharedPrefController().getLang;

  void changeLang() {
    lang = lang == 'en' ? 'ar' : 'en';
    SharedPrefController().changeLang(lang: lang);
    notifyListeners();
  }

}
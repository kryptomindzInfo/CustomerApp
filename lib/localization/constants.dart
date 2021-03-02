import 'package:beyond_wallet/localization/localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';


String getTranslated(BuildContext context, String key){
  return DemoLocalization.of(context).getTranslatedValue(key);
}

const String ENGLISH = 'en';
const String FRENCH = 'fr';
const String LANGUAGE_CODE = 'languageCode';

setLocale(bool isFrench) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.setBool('isFrench', isFrench);
}

Future<bool> getLocale(String key) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  return _prefs.getBool('isFrench');
}

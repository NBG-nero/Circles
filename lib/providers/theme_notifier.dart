import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utilities/constants/constants.dart';

class ThemeNotifier extends ChangeNotifier {
  final String key = 'theme';

  SharedPreferences? prefs;
  bool darkTheme = false;
  var primaryColor = CrColors.primaryColor;
  double fontSize = 14.0.sp;

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  ThemeNotifier() {
    loadFromPref();
    getPrimaryColor();
  }

  toggleTheme() {
    darkTheme = !darkTheme;
    saveToPrefs();
    notifyListeners();
  }

  saveToPrefs() async {
    await initPrefs();
    prefs?.setBool(key, darkTheme);
  }

  loadFromPref() async {
    await initPrefs();
    darkTheme = prefs?.getBool(key) ?? false;
    notifyListeners();
  }

  saveColorToPrefs(val) async {
    await initPrefs();
    prefs?.setInt('primaryColor', val);
  }

  setPrimaryColor(val) {
    primaryColor = Color(val);
    saveColorToPrefs(val);
    notifyListeners();
  }

  getPrimaryColor() async {
    await initPrefs();
    return primaryColor;
  }

  saveFontSizeToPrefs(val) async {
    await initPrefs();
    prefs?.setDouble('fontSize', val);
  }

  changeFontSize(val) {
    fontSize = val;
    saveFontSizeToPrefs(val);
    notifyListeners();
  }

  getFontSizeFromPrefs() async {
    await initPrefs();
    fontSize = prefs?.getDouble('fontSize') ?? 14.0;
  }
}

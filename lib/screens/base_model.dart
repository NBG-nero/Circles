import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class BaseModel extends BaseViewModel {
  SharedPreferences? prefs;

  intiPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }
}

import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

import '../utilities/constants/constants.dart';

class BaseModel extends BaseViewModel {
  SharedPreferences? prefs;

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

 Future<String?> getUserFirebaseId() async {
    await initPrefs();
   return prefs?.getString(FirestoreConstants.id);
    
  }
}

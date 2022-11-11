import 'package:google_sign_in/google_sign_in.dart';

import '../../utilities/constants/constants.dart';
import '../base_model.dart';

enum Status {
  uninitialized,
  authenticated,
  authenticating,
  authenticationError,
  authenticateCanceled,
}

class AuthViewModel extends BaseModel {
  AuthViewModel() {
    loadLoggedfromPrefs();
  }
  final GoogleSignIn googleSignIn = GoogleSignIn();

  final String logged = "LoggedIn";

  bool loggedIn = false;
  
  setLoggedIn(val) {
    loggedIn = val;
    saveLoggedtoprefs();
    notifyListeners();
  }

  saveLoggedtoprefs() async {
    await initPrefs();
    prefs?.setBool(logged, loggedIn);
  }

  loadLoggedfromPrefs() async {
    await initPrefs();
    loggedIn = prefs?.getBool(logged) ?? false;
    notifyListeners();
  }


  Future<bool> setisLoggedIn() async {
    await initPrefs();
    bool isLoggedIn = await googleSignIn.isSignedIn();
    if (isLoggedIn &&
        (prefs?.getString(FirestoreConstants.id)?.isNotEmpty == true)) {
          setLoggedIn(true);
      return true;
    } else {
      return false;
    }
  }
}

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
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<bool> setisLoggedIn() async {
    await intiPrefs();
    bool isLoggedIn = await googleSignIn.isSignedIn();
    if (isLoggedIn &&
        (prefs?.getString(FirestoreConstants.id)?.isNotEmpty == true)) {
      return true;
    } else {
      return false;
    }
  }
}

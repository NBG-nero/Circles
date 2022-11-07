
import 'package:circles/utilities/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import 'package:circles/utilities/constants/constants.dart';

import '../../../models/models.dart';
import '../auth_view_model.dart';

class SignInViewModel extends AuthViewModel {
  final FirebaseAuth firebaseAuth;

  final FirebaseFirestore firebaseFirestore;

  // ignore: prefer_final_fields
  Status _status = Status.uninitialized;

  SignInViewModel(this.firebaseAuth, this.firebaseFirestore);
  // ignore: recursive_getters
  Status get status => _status;

  Future<bool> handleSignIn() async {
    await initPrefs();
    _status = Status.authenticating;
    notifyListeners();
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      GoogleSignInAuthentication? googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      User? firebaseUser =
          (await firebaseAuth.signInWithCredential(credential)).user;

      if (firebaseUser != null) {
        final QuerySnapshot result = await firebaseFirestore
            .collection(FirestoreConstants.pathUserCollection)
            .where(FirestoreConstants.id, isEqualTo: firebaseUser.uid)
            .get();

        final List<DocumentSnapshot> document = result.docs;
        if (document.isEmpty) {
          firebaseFirestore
              .collection(FirestoreConstants.pathUserCollection)
              .doc(firebaseUser.uid)
              .set({
            FirestoreConstants.nickname: firebaseUser.displayName,
            FirestoreConstants.photoUrl: firebaseUser.photoURL,
            FirestoreConstants.id: firebaseUser.uid,
            'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
          });

          User? currentUser = firebaseUser;
          await prefs?.setString(FirestoreConstants.id, currentUser.uid);
          await prefs?.setString(
              FirestoreConstants.nickname, currentUser.displayName ?? '');
          await prefs?.setString(
              FirestoreConstants.photoUrl, currentUser.photoURL ?? '');
          await prefs?.setString(
              FirestoreConstants.phoneNumber, currentUser.phoneNumber ?? '');
        } else {
          DocumentSnapshot documentSnapshot = document[0];
          UserChat userChat = UserChat.fromDocument(documentSnapshot);

          await prefs?.setString(FirestoreConstants.id, userChat.id);
          await prefs?.setString(
              FirestoreConstants.nickname, userChat.nickname);
          await prefs?.setString(
              FirestoreConstants.photoUrl, userChat.photoUrl);
          await prefs?.setString(FirestoreConstants.aboutMe, userChat.aboutMe);
          await prefs?.setString(
              FirestoreConstants.phoneNumber, userChat.phoneNumber);
        }
        _status = Status.authenticated;
        showToast("Sign in successful");
        notifyListeners();
        return true;
      } else {
        _status = Status.authenticationError;
        showErrorToast("Sign in failed");

        notifyListeners();
        return false;
      }
    } else {
      _status = Status.authenticateCanceled;
      showErrorToast("Sign in canceled");

      notifyListeners();
      return false;
    }
  }

  Future<void> handleSignOut() async {
    _status = Status.uninitialized;
    await firebaseAuth.signOut();
    await googleSignIn.disconnect();
    await googleSignIn.signOut();
  }
}

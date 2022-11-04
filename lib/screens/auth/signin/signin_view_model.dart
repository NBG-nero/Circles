import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:circles/utilities/constants/constants.dart';

import '../auth_view_model.dart';

class SignInViewModel extends AuthViewModel {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  final FirebaseFirestore firebaseFirestore;
  // SharedPreferences? prefs;
  // bool? isLoggedIn = false;

  // ignore: prefer_final_fields
  Status _status = Status.uninitialized;

  SignInViewModel(this.firebaseAuth, this.googleSignIn, this.firebaseFirestore);
  // ignore: recursive_getters
  Status get status => _status;

  // initPrefs() async {
  //   prefs = await SharedPreferences.getInstance();
  // }

  String? getUserFirebaseId() {
    return prefs?.getString(FirestoreConstants.id);
  }

  Future<bool> setisLoggedIn() async {
    bool isLoggedIn = await googleSignIn.isSignedIn();
    if (isLoggedIn &&
        (prefs?.getString(FirestoreConstants.id)?.isNotEmpty == true)) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> handleSignIn() async {
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
          // UserChat userChat = UserChat.fromDocument(documentSnapshot);

          // await prefs.setString(FirestoreConstants.id, userChat.id);
          // await prefs.setString(FirestoreConstants.nickname, userChat.nickname);
          // await prefs.setString(FirestoreConstants.photoUrl, userChat.photoUrl);
          // await prefs.setString(FirestoreConstants.aboutMe, userChat.aboutMe);
          // await prefs.setString(
          //     FirestoreConstants.phoneNumber, userChat.phoneNumber);
        }
        _status = Status.authenticated;
        notifyListeners();
        return true;
      } else {
        _status = Status.authenticationError;
        notifyListeners();
        return false;
      }
    } else {
      _status = Status.authenticateCanceled;
      notifyListeners();
      return false;
    }
  }
}

import 'package:circles/screens/auth/auth_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends AuthViewModel {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  int limit = 20;
  int limitIncrement = 20;
  String textSearch = '';
  bool isLoading = false;

  String? currentUserId;
  final ScrollController listScrollController = ScrollController();

  Status _status = Status.uninitialized;

  Status get status => _status;

  Future<void> handleSignOut() async {
    _status = Status.uninitialized;
    await firebaseAuth.signOut();
    await googleSignIn.disconnect();
    await googleSignIn.signOut();
    // setLoggedIn(false);
  }

  scrollListener() {
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        listScrollController.position.outOfRange) {
      limit += limitIncrement;
    }
    // notifyListeners();
  }
}

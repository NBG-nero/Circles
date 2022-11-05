import 'package:circles/utilities/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:stacked/stacked.dart';

import 'package:circles/screens/auth/signin/signin_view_model.dart';

// ignore: must_be_immutable
class SignIn extends StatefulWidget {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  SignIn({
    Key? key,
  }) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInViewModel>.reactive(
        viewModelBuilder: () => SignInViewModel(
            FirebaseAuth.instance, GoogleSignIn(), widget.firebaseFirestore),
        onModelReady: (s) {
          s.setInitialised(true);
        },
        builder: (context, model, child) {
          return Scaffold(
            appBar:
                AppBar(backgroundColor: CrColors.primaryColor.withOpacity(0.8)),
            body: SingleChildScrollView(
                child: Column(
                  children: const  [ 
                   Text('Sign In')])),
          );
        });
  }
}

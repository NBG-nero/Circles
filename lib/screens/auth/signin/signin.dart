import 'package:auto_route/auto_route.dart';
import 'package:circles/screens/auth/auth_view_model.dart';
import 'package:circles/utilities/constants/colors.dart';
// import 'package:circles/utilities/utils.dart';
import 'package:circles/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_sign_in/google_sign_in.dart';

import 'package:stacked/stacked.dart';

import 'package:circles/screens/auth/signin/signin_view_model.dart';

import '../../../routes/router.gr.dart';

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
        viewModelBuilder: () =>
            SignInViewModel(FirebaseAuth.instance, widget.firebaseFirestore),
        onModelReady: (s) {
          s.setInitialised(true);
        },
        builder: (context, model, child) {
          // switch (model.status) {
          //   case Status.authenticationError:
          //     showErrorToast("Sign in failed");
          //     break;
          //   case Status.authenticateCanceled:
          //     showErrorToast("Sign in canceled");
          //     break;
          //   case Status.authenticated:
          //     showToast("Sign in success");
          //     break;
          //   default:
          //     break;
          // }
          return Scaffold(
            backgroundColor: CrColors.primaryColor,
       
            body:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset('assets/images/back.png'),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: () async {
                    bool isSuccess = await model.handleSignIn();
                    if (isSuccess) {
                      // ignore: use_build_context_synchronously
                      AutoRouter.of(context).pushAndPopUntil(const Homescreen(),
                          predicate: (route) => false);
                    }
                  },
                  child: Image.asset('assets/images/google_login.jpg',width:300.w),
                ),
              ),
              
              Container(
                
                child: model.status == Status.authenticating
                    ? const LoadingView()
                    : 
                    // Container( color: Colors.green),
                    const SizedBox.shrink(),
              ),
            ]),
          );
        });
  }
}

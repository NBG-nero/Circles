import 'package:auto_route/auto_route.dart';
import 'package:circles/screens/splash/splash_view_model.dart';
import 'package:circles/utilities/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

import '../../routes/router.gr.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
        viewModelBuilder: () => SplashViewModel(),
        onModelReady: (s) {
          s.setInitialised(true);
          Future.delayed(const Duration(seconds: 5), (() {
            // s.checkSignedIn();
        //  loggedIn = s.loadLoggedfromPrefs();
            
            s.loggedIn == true
                ? AutoRouter.of(context).pushAndPopUntil(const Homescreen(),
                    predicate: (route) => false)
                : AutoRouter.of(context)
                    .pushAndPopUntil(SignIn(), predicate: (route) => false);
          }));
        },
        builder: (context, model, child) {
          return Scaffold(
              backgroundColor: CrColors.primaryColor,
              body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Image.asset(
                        'assets/images/splash.png',
                        // width: 300.w,
                        // height: 300.h,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "World's largest Private Chat App",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          ?.copyWith(color: CrColors.secondaryColor),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    // ignore: sized_box_for_whitespace
                    Container(
                        width: 20.w,
                        height: 20.h,
                        child: CircularProgressIndicator.adaptive(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              CrColors.secondaryColor),
                        )),
                  ],
                ),
              ));
        });
  }
}

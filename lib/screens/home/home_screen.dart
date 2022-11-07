// import 'package:circles/utilities/constants/colors.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

import '../../providers/theme_notifier.dart';
import 'package:provider/provider.dart';

import '../../routes/router.gr.dart';
import '../../utilities/constants/constants.dart';
import 'home_view_model.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);

    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        onModelReady: (h) {
          h.setInitialised(true);
      // Future.delayed(const Duration(seconds: 5), (() {
          if (h.getUserFirebaseId().toString().isNotEmpty == true) {
            h.currentUserId = h.getUserFirebaseId().toString();
          } else {
            AutoRouter.of(context)
                    .pushAndPopUntil(SignIn(), predicate: (route) => false);
          }
            // }));
          h.listScrollController.addListener(h.scrollListener);
        },
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor:
                theme.darkTheme ? Colors.grey.shade800 : CrColors.primaryColor,
            appBar: AppBar(
              backgroundColor: theme.darkTheme
                  ? CrColors.primaryColor.withOpacity(0.7)
                  : CrColors.secondaryColor,
            ),
            drawer: Drawer(
              width: MediaQuery.of(context).size.width * 0.7,
              child: ListView(children: [
                const DrawerHeader(
                  child: Text(""),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Theme'),
                            Transform.scale(
                              scale: 0.47,
                              child: CupertinoSwitch(
                                activeColor: CrColors.primaryColor,
                                value: theme.darkTheme,
                                onChanged: (bool value) {
                                  theme.toggleTheme();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, right: 17),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Settings'),
                            Icon(
                              Icons.settings_outlined,
                              size: 25.h,
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          model.handleSignOut();
                          AutoRouter.of(context).pushAndPopUntil(SignIn(),
                              predicate: (route) => false);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 17, right: 17),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Sign out'),
                              Icon(
                                Icons.logout_outlined,
                                size: 25.h,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ]),
            ),
          );
        });
  }
}

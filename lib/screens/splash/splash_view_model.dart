import 'dart:developer';

import 'package:circles/screens/auth/auth_view_model.dart';

import '../../routes/router.gr.dart';
import '../../utilities/locator.dart';

class SplashViewModel extends AuthViewModel {
  final appRouter = locator<AppRouter>();

  void checkSignedIn() async {
    bool isLoggedIn = await setisLoggedIn();
    if (isLoggedIn) {
      log(isLoggedIn.toString());
      // setLoggedIn(true);
      appRouter.pushAndPopUntil(const Homescreen(),
          predicate: (route) => false);
      return;
    } else {
      log(isLoggedIn.toString());

      // setLoggedIn(false);
      appRouter.pushAndPopUntil(SignIn(), predicate: (route) => false);
    }
  }
}

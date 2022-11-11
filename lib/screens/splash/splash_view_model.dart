import 'package:circles/screens/auth/auth_view_model.dart';

import '../../routes/router.gr.dart';

import '../../utilities/locator.dart';

class SplashViewModel extends AuthViewModel {
  final _appRouter = locator<AppRouter>();
  // bool loggedIn = false;

  void checkSignedIn() async {
    bool isLoggedIn = await setisLoggedIn();
    if (isLoggedIn) {
      _appRouter.pushAndPopUntil(const Homescreen(),
          predicate: (route) => false);
      return;
    }
    _appRouter.pushAndPopUntil(SignIn(), predicate: (route) => false);
  }
}

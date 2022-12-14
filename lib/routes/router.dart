import 'package:auto_route/annotations.dart';

import '../screens/screens.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page, Route',
  routes: <AutoRoute>[
    AutoRoute(page: Splashscreen, initial: true),
    AutoRoute(page: SignIn),

    AutoRoute(page: Homescreen),
    AutoRoute(page: Settings),

  ],
)
class $AppRouter {}

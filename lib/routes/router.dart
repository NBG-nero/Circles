import 'package:auto_route/annotations.dart';

import '../screens/screens.dart';

@MaterialAutoRouter(
replaceInRouteName: 'Page, Route', 
routes: <AutoRoute>[ 
  AutoRoute(page: Homescreen, initial: true),
], 
) 
class $AppRouter {}

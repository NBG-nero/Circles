import 'package:get_it/get_it.dart';

import '../routes/router.gr.dart';

GetIt locator = GetIt.instance;

void setUpLocator() async {
  locator.registerLazySingleton<AppRouter>(() => AppRouter());
}

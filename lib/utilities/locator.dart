import 'package:get_it/get_it.dart';

import '../routes/router.gr.dart';

GetIt locator = GetIt.instance;

Future<void> setUpLocator() async {
  locator.registerLazySingleton(() => AppRouter());
}

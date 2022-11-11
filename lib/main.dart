import 'package:circles/providers/theme_notifier.dart';
import 'package:circles/utilities/constants/constants.dart';

import 'package:firebase_core/firebase_core.dart';

import 'routes/router.gr.dart' as gr;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'utilities/locator.dart';
import 'utilities/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

      /// on mobile
      name: 'Circles',

      /// ondesktop
      // name: defaultAppName,
      options: const FirebaseOptions(
        apiKey: 'AIzaSyARhejUyeDOUTb2HfRkU9fZa3zNReNT2Rg',
        appId: '1:110336865612:android:79e37a8e7287313063cbe9',
        messagingSenderId: '110336865612',
        projectId: 'circles-ffe44',
        storageBucket: 'circles-ffe44.appspot.com',
      ));
  await ScreenUtil.ensureScreenSize();
  setUpLocator();
  runApp(Circles());
}

class Circles extends StatelessWidget {
  Circles({Key? key}) : super(key: key);

  final appRouter = gr.AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => ThemeNotifier(),
          )
        ],
        child: ScreenUtilInit(
            designSize: const Size(428, 926),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return Consumer<ThemeNotifier>(
                builder: (context, theme, child) {
                  return MaterialApp.router(
                    routeInformationParser: appRouter.defaultRouteParser(),
                    routerDelegate: appRouter.delegate(),
                    title: AppConstants.appTitle,
                    debugShowCheckedModeBanner: false,
                    theme: theme.darkTheme
                        ? AppTheme()
                            .darkTheme(theme.primaryColor, theme.fontSize)
                        : AppTheme()
                            .lightTheme(theme.primaryColor, theme.fontSize),
                    builder: (context, widget) {
                      return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(textScaleFactor: 1.0),
                          child: Builder(
                            builder: (context) => widget!,
                          ));
                    },
                  );
                },
              );
            }));
  }
}

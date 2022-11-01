import 'package:circles/providers/theme_notifier.dart';
import 'package:circles/utilities/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'routes/router.gr.dart' as gr;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'utilities/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  // await Firebase.initializeApp();
  runApp(Circles());
}

class Circles extends StatelessWidget {
  Circles({Key? key}) : super(key: key);
  // final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  // final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
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

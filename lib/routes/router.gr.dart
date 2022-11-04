// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i3;

import '../screens/screens.dart' as _i1;

class AppRouter extends _i2.RootStackRouter {
  AppRouter([_i3.GlobalKey<_i3.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    SignIn.name: (routeData) {
      final args =
          routeData.argsAs<SignInArgs>(orElse: () => const SignInArgs());
      return _i2.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i1.SignIn(key: args.key),
      );
    },
    Homescreen.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.Homescreen(),
      );
    },
  };

  @override
  List<_i2.RouteConfig> get routes => [
        _i2.RouteConfig(
          SignIn.name,
          path: '/',
        ),
        _i2.RouteConfig(
          Homescreen.name,
          path: '/Homescreen',
        ),
      ];
}

/// generated route for
/// [_i1.SignIn]
class SignIn extends _i2.PageRouteInfo<SignInArgs> {
  SignIn({_i3.Key? key})
      : super(
          SignIn.name,
          path: '/',
          args: SignInArgs(key: key),
        );

  static const String name = 'SignIn';
}

class SignInArgs {
  const SignInArgs({this.key});

  final _i3.Key? key;

  @override
  String toString() {
    return 'SignInArgs{key: $key}';
  }
}

/// generated route for
/// [_i1.Homescreen]
class Homescreen extends _i2.PageRouteInfo<void> {
  const Homescreen()
      : super(
          Homescreen.name,
          path: '/Homescreen',
        );

  static const String name = 'Homescreen';
}

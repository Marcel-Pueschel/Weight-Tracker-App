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
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;

import '../../domain/entities/weight/weight.dart' as _i9;
import '../home/home_page.dart' as _i3;
import '../login/login_page.dart' as _i2;
import '../settings/user/user_settings_page.dart' as _i5;
import '../settings/weight/weight_goal_settings_page.dart' as _i6;
import '../splash/splash_page.dart' as _i1;
import '../weight/weight_detail_page.dart' as _i4;

class AppRouter extends _i7.RootStackRouter {
  AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    SplashPageRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SplashPage(),
      );
    },
    LoginPageRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.LoginPage(),
      );
    },
    HomePageRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.HomePage(),
      );
    },
    WeightDetailRoute.name: (routeData) {
      final args = routeData.argsAs<WeightDetailRouteArgs>();
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.WeightDetail(
          key: args.key,
          weight: args.weight,
        ),
        fullscreenDialog: true,
      );
    },
    UserSettingsPageRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.UserSettingsPage(),
        fullscreenDialog: true,
      );
    },
    WeightGoalSettingsPageRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.WeightGoalSettingsPage(),
        fullscreenDialog: true,
      );
    },
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(
          SplashPageRoute.name,
          path: '/',
        ),
        _i7.RouteConfig(
          LoginPageRoute.name,
          path: '/login-page',
        ),
        _i7.RouteConfig(
          HomePageRoute.name,
          path: '/home-page',
        ),
        _i7.RouteConfig(
          WeightDetailRoute.name,
          path: '/weight-detail',
        ),
        _i7.RouteConfig(
          UserSettingsPageRoute.name,
          path: '/user-settings-page',
        ),
        _i7.RouteConfig(
          WeightGoalSettingsPageRoute.name,
          path: '/weight-goal-settings-page',
        ),
      ];
}

/// generated route for
/// [_i1.SplashPage]
class SplashPageRoute extends _i7.PageRouteInfo<void> {
  const SplashPageRoute()
      : super(
          SplashPageRoute.name,
          path: '/',
        );

  static const String name = 'SplashPageRoute';
}

/// generated route for
/// [_i2.LoginPage]
class LoginPageRoute extends _i7.PageRouteInfo<void> {
  const LoginPageRoute()
      : super(
          LoginPageRoute.name,
          path: '/login-page',
        );

  static const String name = 'LoginPageRoute';
}

/// generated route for
/// [_i3.HomePage]
class HomePageRoute extends _i7.PageRouteInfo<void> {
  const HomePageRoute()
      : super(
          HomePageRoute.name,
          path: '/home-page',
        );

  static const String name = 'HomePageRoute';
}

/// generated route for
/// [_i4.WeightDetail]
class WeightDetailRoute extends _i7.PageRouteInfo<WeightDetailRouteArgs> {
  WeightDetailRoute({
    _i8.Key? key,
    required _i9.Weight? weight,
  }) : super(
          WeightDetailRoute.name,
          path: '/weight-detail',
          args: WeightDetailRouteArgs(
            key: key,
            weight: weight,
          ),
        );

  static const String name = 'WeightDetailRoute';
}

class WeightDetailRouteArgs {
  const WeightDetailRouteArgs({
    this.key,
    required this.weight,
  });

  final _i8.Key? key;

  final _i9.Weight? weight;

  @override
  String toString() {
    return 'WeightDetailRouteArgs{key: $key, weight: $weight}';
  }
}

/// generated route for
/// [_i5.UserSettingsPage]
class UserSettingsPageRoute extends _i7.PageRouteInfo<void> {
  const UserSettingsPageRoute()
      : super(
          UserSettingsPageRoute.name,
          path: '/user-settings-page',
        );

  static const String name = 'UserSettingsPageRoute';
}

/// generated route for
/// [_i6.WeightGoalSettingsPage]
class WeightGoalSettingsPageRoute extends _i7.PageRouteInfo<void> {
  const WeightGoalSettingsPageRoute()
      : super(
          WeightGoalSettingsPageRoute.name,
          path: '/weight-goal-settings-page',
        );

  static const String name = 'WeightGoalSettingsPageRoute';
}

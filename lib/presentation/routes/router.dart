import 'package:auto_route/annotations.dart';
import 'package:weight_tracker/presentation/home/home_page.dart';
import 'package:weight_tracker/presentation/login/login_page.dart';
import 'package:weight_tracker/presentation/settings/user/user_settings_page.dart';
import 'package:weight_tracker/presentation/settings/weight/weight_goal_settings_page.dart';
import 'package:weight_tracker/presentation/splash/splash_page.dart';
import 'package:weight_tracker/presentation/weight/weight_detail_page.dart';

@MaterialAutoRouter(routes: <AutoRoute>[
  AutoRoute(page: SplashPage, initial: true),
  AutoRoute(page: LoginPage, initial: false),
  AutoRoute(page: HomePage, initial: false),
  AutoRoute(page: WeightDetail, initial: false, fullscreenDialog: true),
  AutoRoute(page: UserSettingsPage, initial: false, fullscreenDialog: true),
  AutoRoute(
      page: WeightGoalSettingsPage, initial: false, fullscreenDialog: true),
])
class $AppRouter {}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker/application/auth/authbloc/auth_bloc.dart';
import 'package:weight_tracker/application/weight/observer/observer_bloc.dart';
import 'package:weight_tracker/application/weight/weightForm/weight_form_bloc.dart';
import 'package:weight_tracker/application/weightGoal/observer/weight_goal_observer_bloc.dart';
import 'package:weight_tracker/injection.dart';
import 'package:weight_tracker/presentation/routes/router.gr.dart' as r;
import 'package:weight_tracker/theme.dart';
import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = r.AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AuthBloc>()..add(AuthCheckRequestedEvent()),
        ),
        BlocProvider<WeightGoalObserverBloc>(
          create: (context) =>
              sl<WeightGoalObserverBloc>()..add(ObserveWeightGoalEvent()),
        ),
        BlocProvider<ObserverBloc>(
          create: (context) => sl<ObserverBloc>()..add(ObserveAllEvent()),
        )
      ],
      child: MaterialApp.router(
        routeInformationParser: _appRouter.defaultRouteParser(),
        routerDelegate: _appRouter.delegate(),
        debugShowCheckedModeBanner: false,
        title: 'Weight Tracker',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
      ),
    );
  }
}

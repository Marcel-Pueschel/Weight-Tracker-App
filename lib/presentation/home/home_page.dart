import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker/application/auth/authbloc/auth_bloc.dart';
import 'package:weight_tracker/application/user/observer/observer_bloc.dart';
import 'package:weight_tracker/injection.dart';
import 'package:weight_tracker/presentation/chart/chart_page.dart';
import 'package:weight_tracker/presentation/home/dashboard_page.dart';
import 'package:weight_tracker/presentation/routes/router.gr.dart';
import 'package:weight_tracker/presentation/settings/settings_page.dart';
import 'package:weight_tracker/presentation/settings/user/user_settings_page.dart';
import 'package:weight_tracker/presentation/weight/weight_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final observerBloc = sl<ObserverBloc>()..add(ObserveAppUserEvent());

    return BlocProvider<ObserverBloc>(
      create: (context) => observerBloc,
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(listener: (context, state) {
            if (state is AuthStateUnauthenticated) {
              AutoRouter.of(context).push(const LoginPageRoute());
            }
          }),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Weight Tracker"),
            actions: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Icon(Icons.fitness_center),
              ),
            ],
            leading: IconButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(SignOutPressedEvent());
              },
              icon: const Icon(Icons.exit_to_app),
            ),
          ),
          body: IndexedStack(
            index: _currentIndex,
            children: const [
              DashboardPage(),
              WeightListPage(),
              ChartPage(),
              SettingsPage(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            currentIndex: _currentIndex,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.white,
            showUnselectedLabels: true,
            backgroundColor: themeData.appBarTheme.backgroundColor,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: "Dashboard",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: "History",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart),
                label: "Chart",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "User settings",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

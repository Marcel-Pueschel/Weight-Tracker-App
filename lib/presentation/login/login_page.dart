import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker/application/auth/loginform/login_form_bloc.dart';
import 'package:weight_tracker/application/auth/registerform/register_form_bloc.dart';
import 'package:weight_tracker/presentation/login/widgets/register_form.dart';
import 'package:weight_tracker/presentation/login/widgets/login_form.dart';

import '../../injection.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return DefaultTabController(
      length: 2,
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context);
        tabController.addListener(() {
          if (!tabController.indexIsChanging) {}
        });

        return Scaffold(
          body: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => sl<RegisterFormBloc>(),
              ),
              BlocProvider(
                create: (context) => sl<LoginFormBloc>(),
              ),
            ],
            child: ListView(
              children: [
                Container(
                  height: 200,
                  child: Center(
                    child: Icon(Icons.fitness_center, size: 50),
                  ),
                ),
                Container(
                  decoration: new BoxDecoration(color: themeData.primaryColor),
                  child: const TabBar(tabs: [
                    Tab(text: 'Sign In'),
                    Tab(text: 'Register'),
                  ]),
                ),
                Container(
                  height: 500,
                  child: TabBarView(
                    children: const [
                      LoginForm(),
                      RegisterForm(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

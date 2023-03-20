import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker/application/auth/authbloc/auth_bloc.dart';
import 'package:weight_tracker/application/auth/registerform/register_form_bloc.dart';
import 'package:weight_tracker/presentation/home/home_page.dart';
import 'package:weight_tracker/presentation/routes/router.gr.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateAuthenticated) {
          context.router.replace(const HomePageRoute());
        } else {
          context.router.replace(const LoginPageRoute());
        }
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: Colors.blue),
        ),
      ),
    );
  }
}

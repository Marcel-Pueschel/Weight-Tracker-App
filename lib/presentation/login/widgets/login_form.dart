import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker/application/auth/loginform/login_form_bloc.dart';
import 'package:weight_tracker/presentation/routes/router.gr.dart';

import '../../core/custom_button.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final themeData = Theme.of(context);

    String? email;
    String? password;

    return BlocConsumer<LoginFormBloc, LoginFormState>(
      listenWhen: (previous, current) =>
          previous.loginFailureOrSuccessOption !=
          current.loginFailureOrSuccessOption,
      listener: (context, state) {
        state.loginFailureOrSuccessOption.fold(
          () => {},
          (eitherFailureOrSuccess) => eitherFailureOrSuccess.fold(
            (failure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.redAccent,
                content: Text(
                  "Wrong username or Password",
                  style: themeData.textTheme.bodyLarge,
                ),
              ));
            },
            (_) => AutoRouter.of(context).replace(const HomePageRoute()),
          ),
        );
      },
      builder: (context, state) {
        return Form(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                cursorColor: Colors.white,
                decoration: const InputDecoration(labelText: "E-Mail"),
                onChanged: (value) => email = value,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  labelText: "Password",
                ),
                onChanged: (value) => password = value,
              ),
              const SizedBox(
                height: 40,
              ),
              CustomButton(
                buttonText: "Login",
                callback: () {
                  if (email == null || password == null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.redAccent,
                      content: Text(
                        "Wrong username or Password",
                        style: themeData.textTheme.bodyLarge,
                      ),
                    ));
                  }

                  BlocProvider.of<LoginFormBloc>(context).add(
                    LoginUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

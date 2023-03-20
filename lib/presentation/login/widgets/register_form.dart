import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker/application/auth/registerform/register_form_bloc.dart';
import 'package:weight_tracker/core/validators/register_form_validator.dart';
import 'package:weight_tracker/presentation/core/custom_button.dart';
import 'package:weight_tracker/presentation/routes/router.gr.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final themeData = Theme.of(context);

    late String _email;
    late String _password;

    return BlocConsumer<RegisterFormBloc, RegisterFormState>(
      listenWhen: (previous, current) =>
          previous.registerFailureOrSuccessOption !=
          current.registerFailureOrSuccessOption,
      listener: (context, state) {
        state.registerFailureOrSuccessOption.fold(
          () => {},
          (eitherFailureOrSuccess) => eitherFailureOrSuccess.fold(
              (failure) => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        RegisterFormValidator.mapFailureMessage(failure),
                        style: themeData.textTheme.bodyLarge,
                      ),
                    ),
                  ),
              (_) => AutoRouter.of(context).replace(const HomePageRoute())),
        );
      },
      builder: (context, state) {
        return Form(
          autovalidateMode: state.showValidationMessage
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              SizedBox(
                height: 40,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.disabled,
                cursorColor: Colors.white,
                decoration: const InputDecoration(labelText: "E-Mail"),
                onChanged: (value) => _email = value,
                validator: RegisterFormValidator.validateEmail,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.disabled,
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  labelText: "Password",
                ),
                validator: RegisterFormValidator.validatePassword,
                onChanged: (value) => _password = value,
              ),
              const SizedBox(
                height: 40,
              ),
              CustomButton(
                buttonText: "Register",
                callback: () {
                  if (formKey.currentState!.validate()) {
                    BlocProvider.of<RegisterFormBloc>(context).add(
                      RegisterUserWithEmailAndPassword(
                          email: _email, password: _password),
                    );
                  } else {
                    BlocProvider.of<RegisterFormBloc>(context).add(
                      RegisterUserWithEmailAndPassword(
                          email: null, password: null),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text(
                          "invalid input",
                          style: themeData.textTheme.bodyLarge,
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker/application/user/appUserForm/app_user_form_bloc.dart';
import 'package:weight_tracker/core/validators/app_user_form_validator.dart';
import 'package:weight_tracker/domain/entities/user/app_user.dart';
import 'package:weight_tracker/presentation/core/custom_button.dart';

class AppUserSettingsForm extends StatelessWidget {
  const AppUserSettingsForm({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final textEditingControllerName = TextEditingController();
    final textEditingControllerLastName = TextEditingController();
    final textEditingControllerHeight = TextEditingController();

    AppUser formUser = AppUser.empty();

    return BlocListener<AppUserFormBloc, AppUserFormState>(
      listenWhen: (previous, current) =>
          previous.failureOrSuccessOption != current.failureOrSuccessOption,
      listener: (context, state) {
        state.failureOrSuccessOption.fold(
          () {},
          (failureOrSuccess) => failureOrSuccess.fold(
            (failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Something went wrong",
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.redAccent,
                ),
              );
            },
            (appUser) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Usersettings saved",
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            },
          ),
        );
      },
      child: BlocConsumer<AppUserFormBloc, AppUserFormState>(
        listenWhen: (previous, current) =>
            previous.isEditing != current.isEditing,
        listener: (context, state) {
          formUser = state.appUser;

          textEditingControllerName.text = formUser.name;
          textEditingControllerLastName.text = formUser.lastName;
          textEditingControllerHeight.text = formUser.height.toString();
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: textEditingControllerName,
                    cursorColor: Colors.white,
                    maxLength: 100,
                    decoration: InputDecoration(
                      labelText: "Name",
                      counterText: "",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: AppUserFormValidator.validateRequiredString,
                    onChanged: (value) =>
                        formUser = formUser.copyWith(name: value),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: textEditingControllerLastName,
                    cursorColor: Colors.white,
                    maxLength: 100,
                    decoration: InputDecoration(
                      labelText: "Last Name",
                      counterText: "",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: AppUserFormValidator.validateRequiredString,
                    onChanged: (value) =>
                        formUser = formUser.copyWith(lastName: value),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: textEditingControllerHeight,
                    cursorColor: Colors.white,
                    maxLength: 100,
                    decoration: InputDecoration(
                      labelText: "Height",
                      counterText: "",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: AppUserFormValidator.validateHeight,
                    onChanged: (value) => formUser =
                        formUser.copyWith(height: double.tryParse(value)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    buttonText: "Save",
                    callback: () {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<AppUserFormBloc>(context)
                            .add(SavePressedAppUserEvent(
                          name: formUser.name,
                          lastName: formUser.lastName,
                          height: formUser.height,
                        ));
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

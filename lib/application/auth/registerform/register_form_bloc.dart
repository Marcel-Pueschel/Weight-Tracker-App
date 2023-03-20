import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:weight_tracker/core/failures/auth_failures.dart';
import 'package:weight_tracker/domain/repositories/user/auth_repository.dart';

part 'register_form_event.dart';
part 'register_form_state.dart';

class RegisterFormBloc extends Bloc<RegisterFormEvent, RegisterFormState> {
  final AuthRepository authRepository;

  RegisterFormBloc({required this.authRepository})
      : super(RegisterFormState(
            isSubmitting: false,
            showValidationMessage: false,
            registerFailureOrSuccessOption: none())) {
    // Spacing Comment

    on<RegisterUserWithEmailAndPassword>((event, emit) async {
      if (event.email == null || event.password == null) {
        emit(state.copyWith(isSubmitting: false, showValidationMessage: true));
      } else {
        emit(state.copyWith(
          isSubmitting: true,
          showValidationMessage: false,
        ));

        final failureOrSuccess =
            await authRepository.registerUserWithEmailAndPassword(
                email: event.email!, password: event.password!);

        emit(state.copyWith(
          isSubmitting: false,
          registerFailureOrSuccessOption: optionOf(failureOrSuccess),
        ));
      }
    });
  }
}

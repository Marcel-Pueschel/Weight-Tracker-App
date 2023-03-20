import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:weight_tracker/core/failures/app_user_failures.dart';
import 'package:weight_tracker/domain/repositories/user/app_user_repository.dart';

import '../../../domain/entities/user/app_user.dart';

part 'app_user_form_event.dart';
part 'app_user_form_state.dart';

class AppUserFormBloc extends Bloc<AppUserFormEvent, AppUserFormState> {
  final AppUserRepository appUserRepository;

  AppUserFormBloc({required this.appUserRepository})
      : super(AppUserFormState.initial()) {
    on<InitializeAppUser>((event, emit) async {
      if (event.appUser != null) {
        emit(state.copyWith(appUser: event.appUser, isEditing: true));
      } else {
        emit(state);
      }
    });

    on<SavePressedAppUserEvent>((event, emit) async {
      Either<AppUserFailure, Unit>? failureOrSuccess;

      emit(state.copyWith(isSaving: true, failureOrSuccessOption: none()));

      if (event.name != null &&
          event.lastName != null &&
          event.height != null) {
        final AppUser editedAppUser = state.appUser.copyWith(
          name: event.name,
          lastName: event.lastName,
          height: event.height,
        );

        if (state.isEditing) {
          failureOrSuccess = await appUserRepository.update(editedAppUser);
        } else {
          failureOrSuccess = await appUserRepository.create(editedAppUser);
        }
      }

      emit(state.copyWith(
        isSaving: false,
        showErrorMessages: true,
        failureOrSuccessOption: optionOf(failureOrSuccess),
      ));
    });
  }
}

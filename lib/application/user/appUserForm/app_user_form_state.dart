// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app_user_form_bloc.dart';

class AppUserFormState {
  final AppUser appUser;
  final bool showErrorMessages;
  final bool isSaving;
  final bool isEditing;
  final bool isInitialized;
  final Option<Either<AppUserFailure, Unit>> failureOrSuccessOption;

  AppUserFormState({
    required this.appUser,
    required this.showErrorMessages,
    required this.isSaving,
    required this.isEditing,
    required this.isInitialized,
    required this.failureOrSuccessOption,
  });

  factory AppUserFormState.initial() => AppUserFormState(
        appUser: AppUser.empty(),
        showErrorMessages: false,
        isSaving: false,
        isEditing: false,
        isInitialized: false,
        failureOrSuccessOption: none(),
      );

  AppUserFormState copyWith({
    AppUser? appUser,
    bool? showErrorMessages,
    bool? isSaving,
    bool? isEditing,
    bool? isInitialized,
    Option<Either<AppUserFailure, Unit>>? failureOrSuccessOption,
  }) {
    return AppUserFormState(
      appUser: appUser ?? this.appUser,
      showErrorMessages: showErrorMessages ?? this.showErrorMessages,
      isSaving: isSaving ?? this.isSaving,
      isEditing: isEditing ?? this.isEditing,
      isInitialized: isInitialized ?? this.isInitialized,
      failureOrSuccessOption:
          failureOrSuccessOption ?? this.failureOrSuccessOption,
    );
  }
}

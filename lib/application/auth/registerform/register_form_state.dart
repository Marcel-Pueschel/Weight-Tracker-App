// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'register_form_bloc.dart';

class RegisterFormState {
  final bool isSubmitting;
  final bool showValidationMessage;
  final Option<Either<AuthFailure, Unit>> registerFailureOrSuccessOption;

  RegisterFormState({
    required this.isSubmitting,
    required this.showValidationMessage,
    required this.registerFailureOrSuccessOption,
  });

  RegisterFormState copyWith({
    bool? isSubmitting,
    bool? showValidationMessage,
    Option<Either<AuthFailure, Unit>>? registerFailureOrSuccessOption,
  }) {
    return RegisterFormState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      showValidationMessage:
          showValidationMessage ?? this.showValidationMessage,
      registerFailureOrSuccessOption:
          registerFailureOrSuccessOption ?? this.registerFailureOrSuccessOption,
    );
  }
}

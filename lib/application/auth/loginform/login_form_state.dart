// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_form_bloc.dart';

class LoginFormState {
  final bool isSubmitting;
  final bool showValidationMessage;
  final Option<Either<AuthFailure, Unit>> loginFailureOrSuccessOption;

  LoginFormState({
    required this.isSubmitting,
    required this.showValidationMessage,
    required this.loginFailureOrSuccessOption,
  });

  LoginFormState copyWith({
    bool? isSubmitting,
    bool? showValidationMessage,
    Option<Either<AuthFailure, Unit>>? loginFailureOrSuccessOption,
  }) {
    return LoginFormState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      showValidationMessage:
          showValidationMessage ?? this.showValidationMessage,
      loginFailureOrSuccessOption:
          loginFailureOrSuccessOption ?? this.loginFailureOrSuccessOption,
    );
  }
}

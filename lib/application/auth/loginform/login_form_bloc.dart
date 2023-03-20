import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:weight_tracker/core/failures/auth_failures.dart';
import 'package:weight_tracker/domain/repositories/user/auth_repository.dart';

part 'login_form_event.dart';
part 'login_form_state.dart';

class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  final AuthRepository authRepository;

  LoginFormBloc({required this.authRepository})
      : super(LoginFormState(
            isSubmitting: false,
            showValidationMessage: false,
            loginFailureOrSuccessOption: none())) {
    on<LoginUserWithEmailAndPassword>((event, emit) async {
      if (event.email == null || event.password == null) {
        emit(state.copyWith(isSubmitting: false, showValidationMessage: true));
      } else {
        emit(state.copyWith(
          isSubmitting: true,
          showValidationMessage: false,
        ));

        final failureOrSuccess =
            await authRepository.signInWithEmailAndPassword(
                email: event.email!, password: event.password!);

        emit(state.copyWith(
            isSubmitting: false,
            loginFailureOrSuccessOption: optionOf(failureOrSuccess)));
      }
    });
  }
}

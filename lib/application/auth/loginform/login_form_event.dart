part of 'login_form_bloc.dart';

class LoginFormEvent {}

class LoginUserWithEmailAndPassword extends LoginFormEvent {
  final String? email;
  final String? password;

  LoginUserWithEmailAndPassword({
    required this.email,
    required this.password,
  });
}

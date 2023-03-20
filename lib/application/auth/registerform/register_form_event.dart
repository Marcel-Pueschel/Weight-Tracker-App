part of 'register_form_bloc.dart';

@immutable
abstract class RegisterFormEvent {}

class RegisterUserWithEmailAndPassword extends RegisterFormEvent {
  final String? email;
  final String? password;

  RegisterUserWithEmailAndPassword({
    required this.email,
    required this.password,
  });
}

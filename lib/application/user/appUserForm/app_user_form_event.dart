// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app_user_form_bloc.dart';

@immutable
abstract class AppUserFormEvent {}

class InitializeAppUser extends AppUserFormEvent {
  final AppUser? appUser;
  InitializeAppUser({required this.appUser});
}

class SavePressedAppUserEvent extends AppUserFormEvent {
  final String? name;
  final String? lastName;
  final double? height;

  SavePressedAppUserEvent({
    required this.name,
    required this.lastName,
    required this.height,
  });
}

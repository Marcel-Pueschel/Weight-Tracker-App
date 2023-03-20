part of 'controller_bloc.dart';

@immutable
abstract class ControllerEvent {}

class UpdateAppUserEvent extends ControllerEvent {
  final AppUser appUser;
  UpdateAppUserEvent({required this.appUser});
}

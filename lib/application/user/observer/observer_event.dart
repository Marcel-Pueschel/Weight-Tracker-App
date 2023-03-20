part of 'observer_bloc.dart';

@immutable
abstract class ObserverEvent {}

class ObserveAppUserEvent extends ObserverEvent {}

class AppUserUpdateEvent extends ObserverEvent {
  final Either<AppUserFailure, Option<AppUser>> failureOrAppUser;
  AppUserUpdateEvent({required this.failureOrAppUser});
}

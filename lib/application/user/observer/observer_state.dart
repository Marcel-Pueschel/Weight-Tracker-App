part of 'observer_bloc.dart';

@immutable
abstract class ObserverState {}

class ObserverInitial extends ObserverState {}

class ObserverLoading extends ObserverState {}

class ObserverFailure extends ObserverState {
  final AppUserFailure appUserFailure;
  ObserverFailure({required this.appUserFailure});
}

class ObserverSuccess extends ObserverState {
  final AppUser appUser;
  ObserverSuccess({required this.appUser});
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:weight_tracker/core/failures/app_user_failures.dart';
import 'package:weight_tracker/domain/entities/user/app_user.dart';
import 'package:weight_tracker/domain/repositories/user/app_user_repository.dart';

part 'observer_event.dart';
part 'observer_state.dart';

class ObserverBloc extends Bloc<ObserverEvent, ObserverState> {
  final AppUserRepository appUserRepository;

  StreamSubscription<Either<AppUserFailure, Option<AppUser>>>?
      _appUserStreamSubsciption;

  ObserverBloc({required this.appUserRepository}) : super(ObserverInitial()) {
    on<ObserveAppUserEvent>((event, emit) async {
      emit(ObserverLoading());
      await _appUserStreamSubsciption?.cancel();
      _appUserStreamSubsciption = appUserRepository.getAppUser().listen(
          (failureOrAppUser) =>
              add(AppUserUpdateEvent(failureOrAppUser: failureOrAppUser)));
    });

    on<AppUserUpdateEvent>((event, emit) {
      event.failureOrAppUser.fold(
        (failure) => emit(ObserverFailure(appUserFailure: failure)),
        (appUserOptional) => emit(
          ObserverSuccess(
              appUser: appUserOptional.getOrElse(() => AppUser.empty())),
        ),
      );
    });
  }

  @override
  Future<void> close() async {
    await _appUserStreamSubsciption?.cancel();
    return super.close();
  }
}

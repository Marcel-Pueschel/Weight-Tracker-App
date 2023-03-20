import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weight_tracker/core/failures/app_user_failures.dart';
import 'package:weight_tracker/domain/entities/user/app_user.dart';
import 'package:weight_tracker/domain/repositories/user/app_user_repository.dart';

part 'controller_event.dart';
part 'controller_state.dart';

class ControllerBloc extends Bloc<ControllerEvent, ControllerState> {
  final AppUserRepository appUserRepository;

  ControllerBloc({required this.appUserRepository})
      : super(ControllerInitial()) {
    on<UpdateAppUserEvent>((event, emit) async {
      emit(ControllerInProgress());

      final failureOrSuccess = await appUserRepository.update(event.appUser);
      failureOrSuccess.fold(
        (failure) => emit(ControllerFailure(appUserFailure: failure)),
        (r) => emit(ControllerSuccess()),
      );
    });
  }
}

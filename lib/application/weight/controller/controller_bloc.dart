import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weight_tracker/core/failures/weight_failures.dart';
import 'package:weight_tracker/domain/entities/weight/weight.dart';
import 'package:weight_tracker/domain/repositories/weight/weight_repository.dart';

part 'controller_event.dart';
part 'controller_state.dart';

class ControllerBloc extends Bloc<ControllerEvent, ControllerState> {
  final WeightRepository weightRepository;

  ControllerBloc({required this.weightRepository})
      : super(ControllerInitial()) {
    on<DeleteWeightEvent>((event, emit) async {
      emit(ControllerInProgress());

      final failureOrSuccess = await weightRepository.delete(event.weight);
      failureOrSuccess.fold(
        (failure) => emit(ControllerFailure(weightFailure: failure)),
        (r) => emit(ControllerSuccess()),
      );
    });

    on<UpdateWeightEvent>((event, emit) async {
      emit(ControllerInProgress());

      final failureOrSuccess = await weightRepository.update(event.weight);
      failureOrSuccess.fold(
        (failure) => emit(ControllerFailure(weightFailure: failure)),
        (r) => emit(ControllerSuccess()),
      );
    });
  }
}

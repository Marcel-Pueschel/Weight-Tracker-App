import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:weight_tracker/core/failures/weight_failures.dart';
import 'package:weight_tracker/domain/entities/weight/weight.dart';
import 'package:weight_tracker/domain/entities/weight/weight_goal.dart';
import 'package:weight_tracker/domain/repositories/weight/weight_repository.dart';

part 'observer_event.dart';
part 'observer_state.dart';

class ObserverBloc extends Bloc<ObserverEvent, ObserverState> {
  final WeightRepository weightRepository;

  StreamSubscription<Either<WeightFailure, List<Weight>>>?
      _weightStreamSubsciption;

  ObserverBloc({required this.weightRepository}) : super(ObserverInitial()) {
    on<ObserveAllEvent>((event, emit) async {
      emit(ObserverLoading());

      await _weightStreamSubsciption?.cancel();
      _weightStreamSubsciption = weightRepository.getAll().listen(
          (failureOrWeightList) => add(
              WeightUpdatedEvent(failureOrWeightList: failureOrWeightList)));
    });

    on<WeightUpdatedEvent>((event, emit) async {
      event.failureOrWeightList.fold(
          (failure) => emit(ObserverFailure(weightFailure: failure)),
          (weightList) => emit(ObserverSuccess(weightList: weightList)));
    });
  }

  @override
  Future<void> close() async {
    await _weightStreamSubsciption?.cancel();
    return super.close();
  }
}

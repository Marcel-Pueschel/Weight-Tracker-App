import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:weight_tracker/core/failures/weight_failures.dart';
import 'package:weight_tracker/domain/entities/weight/weight_goal.dart';
import 'package:weight_tracker/domain/repositories/weight/weight_goal_repository.dart';

part 'weight_goal_observer_event.dart';
part 'weight_goal_observer_state.dart';

class WeightGoalObserverBloc
    extends Bloc<WeightGoalObserverEvent, WeightGoalObserverState> {
  final WeightGoalRepository weightGoalRepository;

  StreamSubscription<Either<WeightFailure, Option<WeightGoal>>>?
      _weightGoalStreamSubscription;

  WeightGoalObserverBloc({required this.weightGoalRepository})
      : super(WeightGoalObserverInitial()) {
    on<ObserveWeightGoalEvent>((event, emit) async {
      emit(WeightGoalObserverLoading());
      await _weightGoalStreamSubscription?.cancel();
      _weightGoalStreamSubscription = weightGoalRepository
          .getWeightGoal()
          .listen((failureOrWeightGoal) => add(
              WeightGoalUpdateEvent(failureOrWeightGoal: failureOrWeightGoal)));
    });

    on<WeightGoalUpdateEvent>((event, emit) {
      event.failureOrWeightGoal.fold(
        (failure) => emit(WeightGoalObserverFailure(weightFailure: failure)),
        (weightGoalOption) => emit(
          WeightGoalObserverSuccess(weightGoal: weightGoalOption),
        ),
      );
    });

    @override
    Future<void> close() async {
      await _weightGoalStreamSubscription?.cancel();
      return super.close();
    }
  }
}

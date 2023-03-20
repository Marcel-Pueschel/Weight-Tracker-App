part of 'weight_goal_observer_bloc.dart';

@immutable
abstract class WeightGoalObserverEvent {}

class ObserveWeightGoalEvent extends WeightGoalObserverEvent {}

class WeightGoalUpdateEvent extends WeightGoalObserverEvent {
  final Either<WeightFailure, Option<WeightGoal>> failureOrWeightGoal;
  WeightGoalUpdateEvent({required this.failureOrWeightGoal});
}

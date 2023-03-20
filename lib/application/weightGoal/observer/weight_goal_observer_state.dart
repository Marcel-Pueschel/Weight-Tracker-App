part of 'weight_goal_observer_bloc.dart';

@immutable
abstract class WeightGoalObserverState {}

class WeightGoalObserverInitial extends WeightGoalObserverState {}

class WeightGoalObserverLoading extends WeightGoalObserverState {}

class WeightGoalObserverFailure extends WeightGoalObserverState {
  final WeightFailure weightFailure;
  WeightGoalObserverFailure({required this.weightFailure});
}

class WeightGoalObserverSuccess extends WeightGoalObserverState {
  final Option<WeightGoal> weightGoal;
  WeightGoalObserverSuccess({required this.weightGoal});
}

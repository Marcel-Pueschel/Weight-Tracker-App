part of 'weight_goal_controller_bloc.dart';

@immutable
abstract class WeightGoalControllerState {}

class WeightGoalControllerInitial extends WeightGoalControllerState {}

class WeightGoalControllerInProgress extends WeightGoalControllerState {}

class WeightGoalControllerSuccess extends WeightGoalControllerState {}

class WeightGoalControllerFailure extends WeightGoalControllerState {
  final WeightFailure weightFailure;
  WeightGoalControllerFailure({required this.weightFailure});
}

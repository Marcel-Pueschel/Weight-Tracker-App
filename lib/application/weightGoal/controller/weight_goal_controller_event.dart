part of 'weight_goal_controller_bloc.dart';

@immutable
abstract class WeightGoalControllerEvent {}

class UpdateWeightGoalEvent extends WeightGoalControllerEvent {
  final WeightGoal weightGoal;
  UpdateWeightGoalEvent({required this.weightGoal});
}

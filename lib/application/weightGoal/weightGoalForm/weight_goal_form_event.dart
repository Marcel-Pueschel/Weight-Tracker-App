// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'weight_goal_form_bloc.dart';

@immutable
abstract class WeightGoalFormEvent {}

class InitializeWeightGoal extends WeightGoalFormEvent {
  final WeightGoal? weightGoal;
  InitializeWeightGoal({required this.weightGoal});
}

class SavePressedWeightGoalEvent extends WeightGoalFormEvent {
  final double? startWeight;
  final double? targetWeight;

  final DateTime? startDate;
  final DateTime? endDate;

  SavePressedWeightGoalEvent({
    required this.startWeight,
    required this.targetWeight,
    required this.startDate,
    required this.endDate,
  });
}

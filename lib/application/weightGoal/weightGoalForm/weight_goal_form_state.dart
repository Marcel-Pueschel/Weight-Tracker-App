// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'weight_goal_form_bloc.dart';

class WeightGoalFormState {
  final WeightGoal weightGoal;
  final bool showErrorMessages;
  final bool isSaving;
  final bool isEditing;
  final Option<Either<WeightFailure, Unit>> failureOrSuccessOption;

  WeightGoalFormState({
    required this.weightGoal,
    required this.showErrorMessages,
    required this.isSaving,
    required this.isEditing,
    required this.failureOrSuccessOption,
  });

  factory WeightGoalFormState.initial() => WeightGoalFormState(
        weightGoal: WeightGoal.empty(),
        showErrorMessages: false,
        isSaving: false,
        isEditing: false,
        failureOrSuccessOption: none(),
      );

  WeightGoalFormState copyWith({
    WeightGoal? weightGoal,
    bool? showErrorMessages,
    bool? isSaving,
    bool? isEditing,
    Option<Either<WeightFailure, Unit>>? failureOrSuccessOption,
  }) {
    return WeightGoalFormState(
      weightGoal: weightGoal ?? this.weightGoal,
      showErrorMessages: showErrorMessages ?? this.showErrorMessages,
      isSaving: isSaving ?? this.isSaving,
      isEditing: isEditing ?? this.isEditing,
      failureOrSuccessOption:
          failureOrSuccessOption ?? this.failureOrSuccessOption,
    );
  }
}

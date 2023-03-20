// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'weight_form_bloc.dart';

class WeightFormState {
  final Weight weight;
  final bool showErrorMessages;
  final bool isSaving;
  final bool isEditing;
  final Option<Either<WeightFailure, Unit>> failureOrSuccessOption;

  WeightFormState({
    required this.weight,
    required this.showErrorMessages,
    required this.isSaving,
    required this.isEditing,
    required this.failureOrSuccessOption,
  });

  factory WeightFormState.initial() => WeightFormState(
      weight: Weight.empty(),
      showErrorMessages: false,
      isSaving: false,
      isEditing: false,
      failureOrSuccessOption: none());

  WeightFormState copyWith({
    Weight? weight,
    bool? showErrorMessages,
    bool? isSaving,
    bool? isEditing,
    Option<Either<WeightFailure, Unit>>? failureOrSuccessOption,
  }) {
    return WeightFormState(
      weight: weight ?? this.weight,
      showErrorMessages: showErrorMessages ?? this.showErrorMessages,
      isSaving: isSaving ?? this.isSaving,
      isEditing: isEditing ?? this.isEditing,
      failureOrSuccessOption:
          failureOrSuccessOption ?? this.failureOrSuccessOption,
    );
  }
}

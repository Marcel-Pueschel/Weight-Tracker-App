import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:weight_tracker/application/weight/weightForm/weight_form_bloc.dart';
import 'package:weight_tracker/core/failures/weight_failures.dart';
import 'package:weight_tracker/domain/entities/weight/weight_goal.dart';
import 'package:weight_tracker/domain/repositories/weight/weight_goal_repository.dart';

part 'weight_goal_form_event.dart';
part 'weight_goal_form_state.dart';

class WeightGoalFormBloc
    extends Bloc<WeightGoalFormEvent, WeightGoalFormState> {
  final WeightGoalRepository weightGoalRepository;

  WeightGoalFormBloc({required this.weightGoalRepository})
      : super(WeightGoalFormState.initial()) {
    on<InitializeWeightGoal>((event, emit) async {
      if (event.weightGoal != null) {
        emit(state.copyWith(weightGoal: event.weightGoal, isEditing: true));
      } else {
        emit(state);
      }
    });

    on<SavePressedWeightGoalEvent>((event, emit) async {
      Either<WeightFailure, Unit>? failureOrSuccess;

      emit(state.copyWith(isSaving: true, failureOrSuccessOption: none()));

      if (event.startWeight != null &&
          event.startDate != null &&
          event.targetWeight != null &&
          event.endDate != null) {
        final editedWeightGoal = state.weightGoal.copyWith(
          startWeight: event.startWeight,
          startDate: event.startDate,
          targetWeight: event.targetWeight,
          endDate: event.endDate,
        );

        if (state.isEditing) {
          failureOrSuccess =
              await weightGoalRepository.update(editedWeightGoal);
        } else {
          failureOrSuccess =
              await weightGoalRepository.create(editedWeightGoal);
        }
      }

      emit(state.copyWith(
        isSaving: false,
        showErrorMessages: true,
        failureOrSuccessOption: optionOf(failureOrSuccess),
      ));
    });
  }
}

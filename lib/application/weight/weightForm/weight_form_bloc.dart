import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:weight_tracker/core/failures/weight_failures.dart';
import 'package:weight_tracker/domain/entities/weight/weight.dart';
import 'package:weight_tracker/domain/repositories/weight/weight_repository.dart';

part 'weight_form_event.dart';
part 'weight_form_state.dart';

class WeightFormBloc extends Bloc<WeightFormEvent, WeightFormState> {
  final WeightRepository weightRepository;

  WeightFormBloc({required this.weightRepository})
      : super(WeightFormState.initial()) {
    on<InitializeWeightDetailPage>((event, emit) {
      if (event.weight != null) {
        emit(state.copyWith(
          weight: event.weight,
          isEditing: true,
        ));
      } else {
        emit(state);
      }
    });

    on<SavePressedEvent>((event, emit) async {
      Either<WeightFailure, Unit>? failureOrSuccess;

      emit(state.copyWith(isSaving: true, failureOrSuccessOption: none()));

      if (event.weight != null && event.date != null) {
        final Weight editedWeight = state.weight.copyWith(
          weight: event.weight,
          date: event.date,
        );

        if (state.isEditing) {
          failureOrSuccess = await weightRepository.update(editedWeight);
        } else {
          failureOrSuccess = await weightRepository.create(editedWeight);
        }
      }

      emit(state.copyWith(
        isSaving: false,
        showErrorMessages: true,
        failureOrSuccessOption: optionOf(failureOrSuccess),
      ));
    });

    on<DateChangedEvent>((event, emit) {
      emit(
        state.copyWith(
          weight: state.weight.copyWith(date: event.date),
        ),
      );
    });
  }
}

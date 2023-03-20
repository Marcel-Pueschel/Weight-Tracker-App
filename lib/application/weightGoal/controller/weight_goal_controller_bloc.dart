import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weight_tracker/core/failures/weight_failures.dart';
import 'package:weight_tracker/domain/entities/weight/weight_goal.dart';
import 'package:weight_tracker/domain/repositories/weight/weight_goal_repository.dart';

part '../controller/weight_goal_controller_event.dart';
part '../controller/weight_goal_controller_state.dart';

class WeightGoalControllerBloc
    extends Bloc<WeightGoalControllerEvent, WeightGoalControllerState> {
  final WeightGoalRepository weightGoalRepository;

  WeightGoalControllerBloc({required this.weightGoalRepository})
      : super(WeightGoalControllerInitial()) {
    on<UpdateWeightGoalEvent>((event, emit) async {
      emit(WeightGoalControllerInProgress());

      final failureOrSuccess =
          await weightGoalRepository.update(event.weightGoal);

      failureOrSuccess.fold(
          (failure) =>
              emit(WeightGoalControllerFailure(weightFailure: failure)),
          (r) => emit(WeightGoalControllerSuccess()));
    });
  }
}

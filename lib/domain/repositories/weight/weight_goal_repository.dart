import 'package:dartz/dartz.dart';
import 'package:weight_tracker/core/failures/weight_failures.dart';
import 'package:weight_tracker/domain/entities/weight/weight_goal.dart';

abstract class WeightGoalRepository {
  Stream<Either<WeightFailure, Option<WeightGoal>>> getWeightGoal();

  Future<Either<WeightFailure, Unit>> create(WeightGoal weightGoal);

  Future<Either<WeightFailure, Unit>> update(WeightGoal weightGoal);

  Future<Either<WeightFailure, Unit>> delete(WeightGoal weightGoal);
}

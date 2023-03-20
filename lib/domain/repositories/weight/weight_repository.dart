import 'package:dartz/dartz.dart';
import 'package:weight_tracker/core/failures/weight_failures.dart';
import 'package:weight_tracker/domain/entities/weight/weight.dart';

abstract class WeightRepository {
  Stream<Either<WeightFailure, List<Weight>>> getAll();

  Future<Either<WeightFailure, Unit>> create(Weight weight);

  Future<Either<WeightFailure, Unit>> update(Weight weight);

  Future<Either<WeightFailure, Unit>> delete(Weight weight);
}

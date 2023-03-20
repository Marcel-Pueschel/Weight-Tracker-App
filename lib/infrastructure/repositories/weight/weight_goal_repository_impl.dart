import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weight_tracker/domain/entities/weight/weight_goal.dart';
import 'package:weight_tracker/core/failures/weight_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:weight_tracker/domain/repositories/weight/weight_goal_repository.dart';
import 'package:weight_tracker/infrastructure/extensions/firebase_helpers.dart';
import 'package:weight_tracker/infrastructure/models/weight/weight_goal_model.dart';

class WeightGoalRepositoryImpl implements WeightGoalRepository {
  final FirebaseFirestore firestore;

  WeightGoalRepositoryImpl({required this.firestore});

  @override
  Stream<Either<WeightFailure, Option<WeightGoal>>> getWeightGoal() async* {
    final userDoc = await firestore.userDocument();

    final snap = await userDoc.weightGoalCollection.limit(1).get();

    if (snap.size == 1) {
      yield* userDoc.weightGoalCollection
          .snapshots()
          .map((snapshot) => right<WeightFailure, Option<WeightGoal>>(
                snapshot.docs
                    .map((doc) =>
                        optionOf(WeightGoalModel.fromFirestore(doc).toDomain()))
                    .first,
              ));
    } else {
      yield* Stream.value(right<WeightFailure, Option<WeightGoal>>(none()));
    }
  }

  @override
  Future<Either<WeightFailure, Unit>> create(WeightGoal weightGoal) async {
    try {
      final userDoc = await firestore.userDocument();
      final weightGoalModel = WeightGoalModel.fromDomain(weightGoal);

      await userDoc.weightGoalCollection
          .doc(weightGoalModel.id)
          .set(weightGoalModel.toMap());

      return right(unit);
    } on FirebaseException catch (e) {
      return left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<WeightFailure, Unit>> update(WeightGoal weightGoal) async {
    try {
      final userDoc = await firestore.userDocument();
      final weightGoalModel = WeightGoalModel.fromDomain(weightGoal);

      await userDoc.weightGoalCollection
          .doc(weightGoalModel.id)
          .update(weightGoalModel.toMap());

      return right(unit);
    } on FirebaseException catch (e) {
      return left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<WeightFailure, Unit>> delete(WeightGoal weightGoal) async {
    try {
      final userDoc = await firestore.userDocument();
      final weightGoalModel = WeightGoalModel.fromDomain(weightGoal);

      await userDoc.weightGoalCollection.doc(weightGoalModel.id).delete();

      return right(unit);
    } on FirebaseException catch (e) {
      return left(UnexpectedFailure());
    }
  }
}

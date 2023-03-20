import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weight_tracker/domain/entities/weight/weight.dart';
import 'package:weight_tracker/core/failures/weight_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:weight_tracker/domain/repositories/weight/weight_repository.dart';
import 'package:weight_tracker/infrastructure/extensions/firebase_helpers.dart';

import '../../models/weight/weight_model.dart';

class WeightRepositoryImpl implements WeightRepository {
  final FirebaseFirestore firestore;

  WeightRepositoryImpl({required this.firestore});

  @override
  Stream<Either<WeightFailure, List<Weight>>> getAll() async* {
    final userDoc = await firestore.userDocument();

    yield* userDoc.weightCollection
        .snapshots()
        .map(
          (snapshot) => right<WeightFailure, List<Weight>>(
            snapshot.docs
                .map((doc) => WeightModel.fromFirestore(doc).toDomain())
                .toList()
              ..sort((a, b) => b.date.compareTo(a.date)),
          ),
        )
        .handleError((e) {
      if (e is FirebaseException) {
        // We check both codes because the error code differs from local to cload database
        if (e.code.contains('permission-denied') ||
            e.code.contains('PERMISSION_DENIED')) {
          return left(InsufficientPermissions());
        } else {
          return left(UnexpectedFailure());
        }
      } else {
        return left(UnexpectedFailure());
      }
    });
  }

  @override
  Future<Either<WeightFailure, Unit>> create(Weight weight) async {
    try {
      final userDoc = await firestore.userDocument();
      final weightModel = WeightModel.fromDomain(weight);

      await userDoc.weightCollection
          .doc(weightModel.id)
          .set(weightModel.toMap());

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.code.contains('PERMISSION_DENIED')) {
        return left(InsufficientPermissions());
      } else {
        return left(UnexpectedFailure());
      }
    }
  }

  @override
  Future<Either<WeightFailure, Unit>> update(Weight weight) async {
    try {
      final userDoc = await firestore.userDocument();
      final weightModel = WeightModel.fromDomain(weight);

      await userDoc.weightCollection
          .doc(weightModel.id)
          .update(weightModel.toMap());

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.code.contains('PERMISSION_DENIED')) {
        return left(InsufficientPermissions());
      } else {
        return left(UnexpectedFailure());
      }
    }
  }

  @override
  Future<Either<WeightFailure, Unit>> delete(Weight weight) async {
    try {
      final userDoc = await firestore.userDocument();
      final weightModel = WeightModel.fromDomain(weight);

      await userDoc.weightCollection.doc(weightModel.id).delete();

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.code.contains('PERMISSION_DENIED')) {
        return left(InsufficientPermissions());
      } else {
        return left(UnexpectedFailure());
      }
    }
  }
}

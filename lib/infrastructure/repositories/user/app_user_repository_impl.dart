import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weight_tracker/domain/entities/user/app_user.dart';
import 'package:weight_tracker/core/failures/app_user_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:weight_tracker/domain/repositories/user/app_user_repository.dart';
import 'package:weight_tracker/infrastructure/extensions/firebase_helpers.dart';
import 'package:weight_tracker/infrastructure/models/user/app_user_model.dart';

class AppUserRepositoryImpl implements AppUserRepository {
  final FirebaseFirestore firestore;

  AppUserRepositoryImpl({required this.firestore});

  @override
  Stream<Either<AppUserFailure, Option<AppUser>>> getAppUser() async* {
    final userDoc = await firestore.userDocument();

    final snap = await userDoc.appUserCollection.limit(1).get();

    if (snap.size == 1) {
      yield* userDoc.appUserCollection
          .snapshots()
          .map((snapshot) => right<AppUserFailure, Option<AppUser>>(
                snapshot.docs
                    .map((doc) =>
                        optionOf(AppUserModel.fromFirestore(doc).toDomain()))
                    .first,
              ));
    }
  }

  @override
  Future<Either<AppUserFailure, Unit>> create(AppUser appUser) async {
    try {
      final userDoc = await firestore.userDocument();
      final appUserModel = AppUserModel.fromDomain(appUser);

      await userDoc.appUserCollection
          .doc(appUserModel.id)
          .set(appUserModel.toMap());
      return right(unit);
    } on FirebaseException catch (e) {
      return left(GeneralAppUserFailure());
    }
  }

  @override
  Future<Either<AppUserFailure, Unit>> update(AppUser appUser) async {
    try {
      final userDoc = await firestore.userDocument();
      final appUserModel = AppUserModel.fromDomain(appUser);

      await userDoc.appUserCollection
          .doc(appUserModel.id)
          .update(appUserModel.toMap());
      return right(unit);
    } on FirebaseException catch (e) {
      return left(GeneralAppUserFailure());
    }
  }

  @override
  Future<Either<AppUserFailure, Unit>> delete(AppUser appUser) async {
    try {
      final userDoc = await firestore.userDocument();
      final appUserModel = AppUserModel.fromDomain(appUser);

      await userDoc.appUserCollection.doc(appUserModel.id).delete();
      return right(unit);
    } on FirebaseException catch (e) {
      return left(GeneralAppUserFailure());
    }
  }
}

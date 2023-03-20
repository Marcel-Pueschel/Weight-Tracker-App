import 'package:dartz/dartz.dart';
import 'package:weight_tracker/core/failures/auth_failures.dart';
import 'package:weight_tracker/domain/entities/user/firebase_user.dart';

abstract class AuthRepository {
  Future<Either<AuthFailure, Unit>> registerUserWithEmailAndPassword(
      {required String email, required String password});

  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword(
      {required String email, required String password});

  Future<void> signOut();

  Option<FirebaseUser> getSignedInUser();
}

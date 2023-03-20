import 'package:dartz/dartz.dart';
import 'package:weight_tracker/core/failures/app_user_failures.dart';
import 'package:weight_tracker/domain/entities/user/app_user.dart';

abstract class AppUserRepository {
  Stream<Either<AppUserFailure, Option<AppUser>>> getAppUser();

  Future<Either<AppUserFailure, Unit>> create(AppUser appUser);

  Future<Either<AppUserFailure, Unit>> update(AppUser appUser);

  Future<Either<AppUserFailure, Unit>> delete(AppUser appUser);
}

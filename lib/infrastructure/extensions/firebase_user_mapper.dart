import 'package:firebase_auth/firebase_auth.dart';
import 'package:weight_tracker/domain/entities/user/firebase_user.dart';
import 'package:weight_tracker/domain/entities/utils/id.dart';

extension FirebaseUserMapper on User {
  FirebaseUser toDomain() {
    return FirebaseUser(id: UniqueID.fromUniqueString(uid));
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weight_tracker/core/errors/errors.dart';
import 'package:weight_tracker/domain/repositories/user/auth_repository.dart';
import 'package:weight_tracker/injection.dart';

extension FireStoreExt on FirebaseFirestore {
  Future<DocumentReference> userDocument() async {
    final userOption = sl<AuthRepository>().getSignedInUser();
    final user = userOption.getOrElse(() => throw NotAuthenticatedError());

    return FirebaseFirestore.instance.collection("users").doc(user.id.value);
  }
}

extension DocumentReferenceExt on DocumentReference {
  CollectionReference<Map<String, dynamic>> get weightCollection =>
      collection("weight");

  CollectionReference<Map<String, dynamic>> get appUserCollection =>
      collection("appUser");

  CollectionReference<Map<String, dynamic>> get weightGoalCollection =>
      collection("weightGoal");
}

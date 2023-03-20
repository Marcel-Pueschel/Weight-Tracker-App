// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:weight_tracker/domain/entities/user/app_user.dart';
import 'package:weight_tracker/domain/entities/utils/id.dart';

class AppUserModel {
  final String id;
  final String name;
  final String lastName;
  final double height;

  AppUserModel({
    required this.id,
    required this.name,
    required this.lastName,
    required this.height,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'lastName': lastName,
      'height': height,
    };
  }

  factory AppUserModel.fromMap(Map<String, dynamic> map) {
    return AppUserModel(
      id: "",
      name: map['name'] as String,
      lastName: map['lastName'] as String,
      height: map['height'] as double,
    );
  }

  factory AppUserModel.fromFirestore(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return AppUserModel.fromMap(doc.data()).copyWith(id: doc.id);
  }

  AppUser toDomain() {
    return AppUser(
      id: UniqueID.fromUniqueString(id),
      name: name,
      lastName: lastName,
      height: height,
    );
  }

  factory AppUserModel.fromDomain(AppUser user) {
    return AppUserModel(
      id: user.id.value,
      name: user.name,
      lastName: user.lastName,
      height: user.height,
    );
  }

  AppUserModel copyWith({
    String? id,
    String? name,
    String? lastName,
    double? height,
  }) {
    return AppUserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      height: height ?? this.height,
    );
  }
}

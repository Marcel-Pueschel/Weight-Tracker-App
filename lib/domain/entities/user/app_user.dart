// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:weight_tracker/domain/entities/utils/id.dart';

class AppUser {
  final UniqueID id;
  final String name;
  final String lastName;
  final double height;

  AppUser({
    required this.id,
    required this.name,
    required this.lastName,
    required this.height,
  });

  factory AppUser.empty() {
    return AppUser(
      id: UniqueID(),
      name: "",
      lastName: "",
      height: 0.0,
    );
  }

  AppUser copyWith({
    UniqueID? id,
    String? name,
    String? lastName,
    double? height,
  }) {
    return AppUser(
      id: id ?? this.id,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      height: height ?? this.height,
    );
  }
}

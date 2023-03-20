// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:weight_tracker/domain/entities/utils/id.dart';
import 'package:weight_tracker/domain/entities/weight/weight_goal.dart';

class WeightGoalModel {
  final String id;
  final double startWeight;
  final double targetWeight;

  final Timestamp startDate;
  final Timestamp endDate;

  WeightGoalModel({
    required this.id,
    required this.startWeight,
    required this.targetWeight,
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'startWeight': startWeight,
      'targetWeight': targetWeight,
      'startDate': startDate,
      'endDate': endDate,
    };
  }

  factory WeightGoalModel.fromMap(Map<String, dynamic> map) {
    return WeightGoalModel(
        id: "",
        startWeight: double.parse(map['startWeight'].toString()),
        targetWeight: double.parse(map['targetWeight'].toString()),
        startDate: map['startDate'] as Timestamp,
        endDate: map['endDate'] as Timestamp);
  }

  factory WeightGoalModel.fromFirestore(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return WeightGoalModel.fromMap(doc.data()).copyWith(id: doc.id);
  }

  WeightGoal toDomain() {
    return WeightGoal(
        id: UniqueID.fromUniqueString(id),
        startWeight: startWeight,
        targetWeight: targetWeight,
        startDate: startDate.toDate(),
        endDate: endDate.toDate());
  }

  factory WeightGoalModel.fromDomain(WeightGoal weightGoal) {
    return WeightGoalModel(
        id: weightGoal.id.value,
        startWeight: weightGoal.startWeight,
        targetWeight: weightGoal.targetWeight,
        startDate: Timestamp.fromDate(weightGoal.startDate),
        endDate: Timestamp.fromDate(weightGoal.endDate));
  }

  WeightGoalModel copyWith({
    String? id,
    double? startWeight,
    double? targetWeight,
    Timestamp? startDate,
    Timestamp? endDate,
  }) {
    return WeightGoalModel(
      id: id ?? this.id,
      startWeight: startWeight ?? this.startWeight,
      targetWeight: targetWeight ?? this.targetWeight,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}

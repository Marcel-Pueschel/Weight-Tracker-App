// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:weight_tracker/domain/entities/utils/id.dart';

class WeightGoal {
  final UniqueID id;
  final double startWeight;
  final double targetWeight;

  final DateTime startDate;
  final DateTime endDate;

  WeightGoal({
    required this.id,
    required this.startWeight,
    required this.targetWeight,
    required this.startDate,
    required this.endDate,
  });

  factory WeightGoal.empty() {
    return WeightGoal(
      id: UniqueID(),
      startWeight: 0.0,
      targetWeight: 0.0,
      startDate: DateTime.now(),
      endDate: DateTime.now(),
    );
  }

  WeightGoal copyWith({
    UniqueID? id,
    double? startWeight,
    double? targetWeight,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return WeightGoal(
      id: id ?? this.id,
      startWeight: startWeight ?? this.startWeight,
      targetWeight: targetWeight ?? this.targetWeight,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}

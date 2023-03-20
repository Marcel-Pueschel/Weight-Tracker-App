// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:weight_tracker/domain/entities/utils/id.dart';

class Weight {
  final UniqueID id;
  final double weight;
  final DateTime date;

  Weight({
    required this.id,
    required this.weight,
    required this.date,
  });

  factory Weight.empty() {
    return Weight(
      id: UniqueID(),
      weight: 0.0,
      date: DateTime.now(),
    );
  }

  Weight copyWith({
    UniqueID? id,
    double? weight,
    DateTime? date,
  }) {
    return Weight(
      id: id ?? this.id,
      weight: weight ?? this.weight,
      date: date ?? this.date,
    );
  }
}

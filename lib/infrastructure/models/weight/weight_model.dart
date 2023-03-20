// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:weight_tracker/domain/entities/utils/id.dart';

import '../../../domain/entities/weight/weight.dart';

class WeightModel {
  final String id;
  final double weight;
  final Timestamp date;

  WeightModel({
    required this.id,
    required this.weight,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'weight': weight,
      'date': date,
    };
  }

  factory WeightModel.fromMap(Map<String, dynamic> map) {
    return WeightModel(
      id: "",
      weight: double.parse(map['weight'].toString()),
      date: map["date"] as Timestamp,
    );
  }

  WeightModel copyWith({
    String? id,
    double? weight,
    Timestamp? date,
  }) {
    return WeightModel(
      id: id ?? this.id,
      weight: weight ?? this.weight,
      date: date ?? this.date,
    );
  }

  factory WeightModel.fromFirestore(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return WeightModel.fromMap(doc.data()).copyWith(id: doc.id);
  }

  Weight toDomain() {
    return Weight(
      id: UniqueID.fromUniqueString(id),
      weight: weight,
      date: DateTime.parse(date.toDate().toString()),
    );
  }

  factory WeightModel.fromDomain(Weight weight) {
    return WeightModel(
      id: weight.id.value,
      weight: weight.weight,
      date: Timestamp.fromDate(weight.date),
    );
  }
}

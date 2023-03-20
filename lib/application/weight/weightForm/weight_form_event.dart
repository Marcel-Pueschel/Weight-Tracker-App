part of 'weight_form_bloc.dart';

@immutable
abstract class WeightFormEvent {}

class InitializeWeightDetailPage extends WeightFormEvent {
  final Weight? weight;
  InitializeWeightDetailPage({required this.weight});
}

class SavePressedEvent extends WeightFormEvent {
  final double? weight;
  final DateTime? date;

  SavePressedEvent({required this.weight, required this.date});
}

class DateChangedEvent extends WeightFormEvent {
  final DateTime date;

  DateChangedEvent({required this.date});
}

part of 'controller_bloc.dart';

@immutable
abstract class ControllerEvent {}

class DeleteWeightEvent extends ControllerEvent {
  final Weight weight;
  DeleteWeightEvent({required this.weight});
}

class UpdateWeightEvent extends ControllerEvent {
  final Weight weight;
  UpdateWeightEvent({required this.weight});
}

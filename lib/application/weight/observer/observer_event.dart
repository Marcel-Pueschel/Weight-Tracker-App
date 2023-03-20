part of 'observer_bloc.dart';

@immutable
abstract class ObserverEvent {}

class ObserveAllEvent extends ObserverEvent {}

class WeightUpdatedEvent extends ObserverEvent {
  final Either<WeightFailure, List<Weight>> failureOrWeightList;
  WeightUpdatedEvent({required this.failureOrWeightList});
}

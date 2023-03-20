part of 'observer_bloc.dart';

@immutable
abstract class ObserverState {}

class ObserverInitial extends ObserverState {}

class ObserverLoading extends ObserverState {}

class ObserverFailure extends ObserverState {
  final WeightFailure weightFailure;
  ObserverFailure({required this.weightFailure});
}

class ObserverSuccess extends ObserverState {
  final List<Weight> weightList;
  ObserverSuccess({required this.weightList});
}

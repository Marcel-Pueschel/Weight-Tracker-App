import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker/application/weight/observer/observer_bloc.dart';
import 'package:weight_tracker/presentation/weight/widgets/weight_card.dart';

class WeightListBody extends StatelessWidget {
  const WeightListBody({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return BlocBuilder<ObserverBloc, ObserverState>(
      builder: (context, state) {
        if (state is ObserverInitial) {
          return Container();
        } else if (state is ObserverLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: themeData.colorScheme.secondary,
            ),
          );
        } else if (state is ObserverFailure) {
          return const Center(
            child: Text("Observer Failure"),
          );
        } else if (state is ObserverSuccess) {
          return ListView.builder(
            padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
            itemCount: state.weightList.length,
            itemBuilder: (context, index) {
              final weight = state.weightList[index];
              if (index + 1 < state.weightList.length) {
                final formerWeight = state.weightList[index + 1];
                return WeightCard(
                  weight: weight,
                  formerWeight: formerWeight,
                );
              } else {
                return WeightCard(weight: weight);
              }
            },
          );
        }

        return Container();
      },
    );
  }
}

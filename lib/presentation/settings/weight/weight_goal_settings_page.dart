import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker/application/weightGoal/observer/weight_goal_observer_bloc.dart';
import 'package:weight_tracker/application/weightGoal/weightGoalForm/weight_goal_form_bloc.dart';
import 'package:weight_tracker/injection.dart';
import 'package:weight_tracker/presentation/settings/weight/widgets/weight_goal_settings_form.dart';

class WeightGoalSettingsPage extends StatelessWidget {
  const WeightGoalSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final weightGoalObserverBloc = sl<WeightGoalObserverBloc>()
      ..add(ObserveWeightGoalEvent());
    final themeData = Theme.of(context);

    return BlocProvider<WeightGoalObserverBloc>(
      create: (context) => weightGoalObserverBloc,
      child: BlocBuilder<WeightGoalObserverBloc, WeightGoalObserverState>(
        builder: (context, state) {
          if (state is WeightGoalObserverInitial) {
            return Container();
          } else if (state is WeightGoalObserverLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: themeData.colorScheme.secondary,
              ),
            );
          } else if (state is WeightGoalObserverFailure) {
            return const Center(
              child: Text("Observer Failure"),
            );
          } else if (state is WeightGoalObserverSuccess) {
            return BlocProvider(
              create: (context) => sl<WeightGoalFormBloc>()
                ..add(InitializeWeightGoal(
                    weightGoal: state.weightGoal
                        .fold(() => null, (weightGoal) => weightGoal))),
              child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text("Weight Goal Settings"),
                ),
                body: const WeightGoalSettingsForm(),
              ),
            );
          }

          return const CircularProgressIndicator(color: Colors.blue);
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker/application/user/observer/observer_bloc.dart';
import 'package:weight_tracker/application/weight/observer/observer_bloc.dart'
    as weight;
import 'package:weight_tracker/application/weightGoal/observer/weight_goal_observer_bloc.dart';
import 'package:weight_tracker/domain/entities/weight/weight_goal.dart';
import 'package:weight_tracker/injection.dart';
import 'package:weight_tracker/presentation/home/widgets/dashboard_dashlet.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return BlocBuilder<weight.ObserverBloc, weight.ObserverState>(
      builder: (weightContext, weightState) {
        return BlocBuilder<WeightGoalObserverBloc, WeightGoalObserverState>(
          builder: (weightGoalContext, weightGoalState) {
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
                } else if (state is ObserverSuccess &&
                    weightGoalState is WeightGoalObserverSuccess &&
                    weightState is weight.ObserverSuccess) {
                  return DashBoardDashlet(
                    appUser: state.appUser,
                    weightGoal: weightGoalState.weightGoal
                        .getOrElse(() => WeightGoal.empty()),
                    currenWeight: weightState.weightList.first,
                  );
                }

                return const CircularProgressIndicator(color: Colors.blue);
              },
            );
          },
        );
      },
    );
  }
}

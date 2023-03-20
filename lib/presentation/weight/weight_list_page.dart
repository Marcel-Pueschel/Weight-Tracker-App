import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker/application/weight/observer/observer_bloc.dart';
import 'package:weight_tracker/injection.dart';
import 'package:weight_tracker/presentation/routes/router.gr.dart';
import 'package:weight_tracker/presentation/weight/widgets/weight_list_body.dart';

class WeightListPage extends StatelessWidget {
  const WeightListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final observerBloc = sl<ObserverBloc>()..add(ObserveAllEvent());

    return BlocProvider<ObserverBloc>(
      create: (context) => observerBloc,
      child: Scaffold(
        body: const WeightListBody(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () {
            AutoRouter.of(context).push(WeightDetailRoute(weight: null));
          },
          child: const Icon(
            Icons.add,
            size: 26,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

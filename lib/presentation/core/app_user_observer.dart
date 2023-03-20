import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker/application/user/observer/observer_bloc.dart';
import 'package:weight_tracker/injection.dart';

class AppUserObserverBlocBuilder extends StatelessWidget {
  final Widget child;
  AppUserObserverBlocBuilder({super.key, required this.child});

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
          return child;
        }

        return const CircularProgressIndicator(color: Colors.blue);
      },
    );
  }
}

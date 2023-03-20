import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker/application/user/appUserForm/app_user_form_bloc.dart';
import 'package:weight_tracker/application/user/observer/observer_bloc.dart';
import 'package:weight_tracker/injection.dart';
import 'package:weight_tracker/presentation/settings/user/wigets/user_settings_form.dart';

class UserSettingsPage extends StatelessWidget {
  const UserSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final observerBloc = sl<ObserverBloc>()..add(ObserveAppUserEvent());
    final themeData = Theme.of(context);

    return BlocProvider<ObserverBloc>(
      create: (context) => observerBloc,
      child: BlocBuilder<ObserverBloc, ObserverState>(
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
            return BlocProvider(
              create: (context) => sl<AppUserFormBloc>()
                ..add(InitializeAppUser(appUser: state.appUser)),
              child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text("User Settings"),
                ),
                body: const AppUserSettingsForm(),
              ),
            );
          }

          return const CircularProgressIndicator(color: Colors.blue);
        },
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:weight_tracker/presentation/routes/router.gr.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
      itemCount: 2,
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return InkResponse(
              onTap: () {
                AutoRouter.of(context).push(const UserSettingsPageRoute());
              },
              child: const Card(
                elevation: 16,
                child: ListTile(
                  title: Text("User Settings"),
                ),
              ),
            );
          case 1:
            return InkResponse(
              onTap: () {
                AutoRouter.of(context).push(WeightGoalSettingsPageRoute());
              },
              child: const Card(
                elevation: 16,
                child: ListTile(
                  title: Text("Weight Goal Settings"),
                ),
              ),
            );
          default:
            break;
        }
      },
    );
  }
}

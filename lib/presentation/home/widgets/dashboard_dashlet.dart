import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weight_tracker/domain/entities/user/app_user.dart';
import 'package:weight_tracker/domain/entities/weight/weight.dart';
import 'package:weight_tracker/domain/entities/weight/weight_goal.dart';

class DashBoardDashlet extends StatelessWidget {
  final AppUser appUser;
  final WeightGoal weightGoal;
  final Weight currenWeight;

  const DashBoardDashlet(
      {super.key,
      required this.appUser,
      required this.weightGoal,
      required this.currenWeight});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat("dd-MM-yyyy");

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Center(
        child: Container(
          height: 350,
          width: MediaQuery.of(context).size.width,
          child: Card(
            elevation: 16,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Hallo ${appUser.name}!",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "${weightGoal.startWeight} KG",
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          dateFormat.format(weightGoal.startDate),
                          textAlign: TextAlign.left,
                        )
                      ],
                    ),
                    Column(children: [
                      Text(
                        "${currenWeight.weight} KG",
                        textAlign: TextAlign.center,
                      ),
                    ]),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "${weightGoal.targetWeight} KG",
                          textAlign: TextAlign.right,
                        ),
                        Text(
                          dateFormat.format(weightGoal.endDate),
                          textAlign: TextAlign.right,
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

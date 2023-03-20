import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weight_tracker/domain/entities/weight/weight.dart';
import 'package:weight_tracker/presentation/routes/router.gr.dart';

class WeightCard extends StatelessWidget {
  final Weight weight;
  final Weight? formerWeight;
  const WeightCard({super.key, required this.weight, this.formerWeight});

  Icon getLeadingIcon() {
    if (formerWeight != null) {
      if (weight.weight > formerWeight!.weight) {
        return const Icon(Icons.trending_up);
      } else if (weight.weight < formerWeight!.weight) {
        return const Icon(Icons.trending_down);
      }
    }

    return const Icon(Icons.trending_neutral);
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final dateFormat = DateFormat("dd-MM-yyyy HH:mm");

    return InkResponse(
      onTap: () {
        AutoRouter.of(context).push(WeightDetailRoute(weight: weight));
      },
      child: Card(
        elevation: 16,
        child: ListTile(
          leading: getLeadingIcon(),
          title: Text(
            "${weight.weight} KG",
            style: themeData.textTheme.headlineLarge!
                .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          trailing: Text(
            dateFormat.format(weight.date),
            style: themeData.textTheme.headlineLarge!
                .copyWith(fontSize: 14, fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
  }
}

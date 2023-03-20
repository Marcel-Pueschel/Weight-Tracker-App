import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker/application/weight/weightForm/weight_form_bloc.dart';
import 'package:weight_tracker/domain/entities/weight/weight.dart';
import 'package:weight_tracker/injection.dart';
import 'package:weight_tracker/presentation/routes/router.gr.dart';
import 'package:weight_tracker/presentation/weight/widgets/weight_form.dart';

class WeightDetail extends StatelessWidget {
  final Weight? weight;
  const WeightDetail({super.key, required this.weight});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<WeightFormBloc>()..add(InitializeWeightDetailPage(weight: weight)),
      child: BlocConsumer<WeightFormBloc, WeightFormState>(
        listenWhen: (previous, current) =>
            previous.failureOrSuccessOption != current.failureOrSuccessOption,
        listener: (context, state) {
          state.failureOrSuccessOption.fold(
            () => {},
            (eitherFailureOrSuccess) => eitherFailureOrSuccess.fold(
              (failure) => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("failure"),
                  backgroundColor: Colors.red,
                ),
              ),
              (_) => Navigator.of(context).popUntil(
                  (route) => route.settings.name == HomePageRoute.name),
            ),
          );
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(weight == null ? "Add Weight" : "Edit Weight"),
            ),
            body: Stack(children: [
              const WeightForm(),
            ]),
          );
        },
      ),
    );
  }
}

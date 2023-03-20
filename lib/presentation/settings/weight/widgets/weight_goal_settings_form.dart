import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker/application/weightGoal/weightGoalForm/weight_goal_form_bloc.dart';
import 'package:weight_tracker/core/validators/weight_form_validator.dart';
import 'package:weight_tracker/domain/entities/weight/weight_goal.dart';
import 'package:weight_tracker/presentation/core/custom_button.dart';

class WeightGoalSettingsForm extends StatelessWidget {
  const WeightGoalSettingsForm({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final textEditingControllerStartWeight = TextEditingController();
    final textEditingControllerStartDate = TextEditingController();
    final textEditingControllerTargetWeight = TextEditingController();
    final textEditingControllerEndDate = TextEditingController();

    WeightGoal formWeightGoal = WeightGoal.empty();

    return BlocListener<WeightGoalFormBloc, WeightGoalFormState>(
      listenWhen: (previous, current) =>
          previous.failureOrSuccessOption != current.failureOrSuccessOption,
      listener: (context, state) {
        state.failureOrSuccessOption.fold(
          () {},
          (failureOrSuccess) => failureOrSuccess.fold(
            (failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Something went wrong",
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.redAccent,
                ),
              );
            },
            (weightGoal) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Weight Goal saved",
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            },
          ),
        );
      },
      child: BlocConsumer<WeightGoalFormBloc, WeightGoalFormState>(
        listenWhen: (previous, current) =>
            previous.isEditing != current.isEditing,
        listener: (context, state) {
          formWeightGoal = state.weightGoal;

          textEditingControllerStartWeight.text =
              formWeightGoal.startWeight.toString();
          textEditingControllerStartDate.text =
              formWeightGoal.startDate.toString();
          textEditingControllerTargetWeight.text =
              formWeightGoal.targetWeight.toString();
          textEditingControllerEndDate.text = formWeightGoal.endDate.toString();
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: textEditingControllerStartWeight,
                    cursorColor: Colors.white,
                    maxLength: 100,
                    decoration: InputDecoration(
                      labelText: "Start Weight",
                      counterText: "",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: WeightFormValidator.validateWeight,
                    onChanged: (value) => formWeightGoal = formWeightGoal
                        .copyWith(startWeight: double.parse(value)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DateTimePicker(
                    controller: textEditingControllerStartDate,
                    type: DateTimePickerType.date,
                    initialDate: formWeightGoal.startDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    dateLabelText: "Date",
                    dateMask: "dd-MM-yyyy HH:mm",
                    onChanged: (value) => formWeightGoal = formWeightGoal
                        .copyWith(startDate: DateTime.parse(value)),
                    validator: WeightFormValidator.validateDate,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: textEditingControllerTargetWeight,
                    cursorColor: Colors.white,
                    maxLength: 100,
                    decoration: InputDecoration(
                      labelText: "Target Weight",
                      counterText: "",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: WeightFormValidator.validateWeight,
                    onChanged: (value) => formWeightGoal = formWeightGoal
                        .copyWith(targetWeight: double.parse(value)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DateTimePicker(
                    controller: textEditingControllerEndDate,
                    type: DateTimePickerType.date,
                    initialDate: formWeightGoal.endDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    dateLabelText: "Date",
                    dateMask: "dd-MM-yyyy HH:mm",
                    onChanged: (value) => formWeightGoal =
                        formWeightGoal.copyWith(endDate: DateTime.parse(value)),
                    validator: WeightFormValidator.validateDate,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      buttonText: "Save",
                      callback: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<WeightGoalFormBloc>(context)
                              .add(SavePressedWeightGoalEvent(
                            startWeight: formWeightGoal.startWeight,
                            targetWeight: formWeightGoal.targetWeight,
                            startDate: formWeightGoal.startDate,
                            endDate: formWeightGoal.endDate,
                          ));
                        }
                      })
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

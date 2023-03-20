import 'dart:ffi';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker/application/weight/weightForm/weight_form_bloc.dart';
import 'package:weight_tracker/core/validators/weight_form_validator.dart';
import 'package:weight_tracker/presentation/core/custom_button.dart';

class WeightForm extends StatelessWidget {
  const WeightForm({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final textEditingControllerWeight = TextEditingController();
    final textEditingControllerDate = TextEditingController();

    late double weight;
    DateTime date = DateTime.now();

    return BlocConsumer<WeightFormBloc, WeightFormState>(
      listenWhen: (previous, current) =>
          previous.isEditing != current.isEditing,
      listener: (context, state) {
        weight = state.weight.weight;
        date = state.weight.date;
        textEditingControllerWeight.text = state.weight.weight.toString();
        textEditingControllerDate.text = state.weight.date.toString();
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Form(
            key: formKey,
            autovalidateMode: state.showErrorMessages
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: ListView(
              children: [
                TextFormField(
                  controller: textEditingControllerWeight,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Weight",
                    counterText: "",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (value) => weight = double.parse(value),
                  validator: WeightFormValidator.validateWeight,
                ),
                const SizedBox(
                  height: 20,
                ),
                DateTimePicker(
                  controller: textEditingControllerDate,
                  type: DateTimePickerType.dateTime,
                  initialDate: date,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  dateLabelText: "Date",
                  dateMask: "dd-MM-yyyy HH:mm",
                  onChanged: (value) => date = DateTime.parse(value),
                  validator: WeightFormValidator.validateDate,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                    buttonText: "Save",
                    callback: () {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<WeightFormBloc>(context).add(
                          SavePressedEvent(weight: weight, date: date),
                        );
                      }
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}

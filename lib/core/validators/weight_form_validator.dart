import 'package:weight_tracker/core/validators/core_validator.dart';

class WeightFormValidator {
  static String? validateWeight(String? input) {
    if (input == null || input.trim().isEmpty) {
      return "Please enter a weight";
    } else if (double.tryParse(input) == null) {
      return "Please enter a valid weight(number)";
    }

    double weight = double.parse(input);
    if (weight < 20 || weight > 600) {
      return "Invalid weight! Please enter a value between 20kg and 600kg";
    }

    return null;
  }

  static String? validateDate(String? input) {
    return CoreValidator.validateDate(input);
  }
}

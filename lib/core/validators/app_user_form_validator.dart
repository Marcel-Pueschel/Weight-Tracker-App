import 'package:weight_tracker/core/validators/core_validator.dart';
import 'package:weight_tracker/core/validators/weight_form_validator.dart';

class AppUserFormValidator extends CoreValidator {
  static String? validateEmail(String? input) {
    return CoreValidator.validateEmail(input);
  }

  static String? validateRequiredString(String? input) {
    return CoreValidator.validateRequiredString(input);
  }

  static String? validateHeight(String? input) {
    if (input == null || input.isEmpty) {
      return "Please enter a value";
    } else if (double.tryParse(input) == null) {
      return "Please enter a valid height(number)";
    }

    double height = double.parse(input);
    if (height < 0.50 || height > 2.80) {
      return "Invalid height! Please enter a value between 0.50m and 2.80m";
    }
  }

  static String? validateWeight(String? input) {
    return WeightFormValidator.validateWeight(input);
  }
}

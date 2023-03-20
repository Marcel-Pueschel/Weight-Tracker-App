import 'package:weight_tracker/core/failures/auth_failures.dart';
import 'package:weight_tracker/core/validators/core_validator.dart';

class RegisterFormValidator {
  static String? validateEmail(String? input) {
    return CoreValidator.validateEmail(input);
  }

  static String? validatePassword(String? input) {
    if (input == null || input.isEmpty) {
      return "please enter password";
    } else if (input.length >= 6) {
      //_password = input;
      return null;
    } else {
      return "short password";
    }
  }

  static String mapFailureMessage(AuthFailure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "Something went wrong";
      case EmailAlreadyInUseFailure:
        return "Email already in user";
      case InvalidEmailAndPasswordCombinationFailure:
        return "Invalid email and password combination";
      default:
        return "Something went wrong";
    }
  }
}

class CoreValidator {
  static String? validateEmail(String? input) {
    const emailRegex =
        r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";

    if (input == null || input.isEmpty) {
      return "please enter email";
    } else if (RegExp(emailRegex).hasMatch(input)) {
      //_email = input;
      return null;
    } else {
      return "invalid email format";
    }
  }

  static String? validateDate(String? input) {
    if (input == null) {
      return "Please enter a date";
    } else if (DateTime.tryParse(input) == null) {
      return "Pleas enter a valid date";
    }

    return null;
  }

  static String? validateRequiredString(String? input) {
    if (input == null || input.isEmpty) {
      return "Please enter a value";
    }

    return null;
  }
}

import 'package:sahl_edu/core/extensions/non_null_extensions.dart';
import 'package:sahl_edu/core/resources/resources.dart';

class Validators {
  static String? emailValidator(String? input) {
    return !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(input.orEmpty)
        ? AppStrings.emailValidator
        : null;
  }

  static String? passwordValidator(String? input) {
    return input.orEmpty.length < 8 ? AppStrings.passwordValidator : null;
  }

  static String? emptyValidator(String? input) {
    return input.orEmpty.isEmpty ? AppStrings.required : null;
  }
}

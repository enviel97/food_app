import 'package:email_validator/email_validator.dart';

class Validation {
  final String fieldName;
  const Validation(this.fieldName);

  String? require(String? value) {
    if (value?.isEmpty ?? true) return '$fieldName is required';
    return null;
  }

  String? isEmail(String? value) {
    if (value?.isEmpty ?? true) return '$fieldName is required';

    if (!EmailValidator.validate(value!)) return '$fieldName is invalid';

    return null;
  }

  String? isPassword(String? value) {
    if (value?.isEmpty ?? true) return '$fieldName is not empty';

    // 1
    final hasUpper = RegExp(r'[A-Z]');
    final hasLower = RegExp(r'[a-z]');
    final hasDigit = RegExp(r'\d');
    final hasPunct = RegExp(r'[!?.@#\$&*~-]');
    // 2
    if (!RegExp(r'.{8,}').hasMatch(value!)) {
      return '$fieldName must have at least 8 characters';
    }
    // 3
    if (!hasUpper.hasMatch(value)) {
      return '$fieldName must have at least one uppercase character';
    }
    // 4
    if (!hasLower.hasMatch(value)) {
      return '$fieldName must have at least one lowercase character';
    }
    // 5
    if (!hasDigit.hasMatch(value)) {
      return '$fieldName must have at least one number';
    }
    // 6
    if (!hasPunct.hasMatch(value)) {
      return '$fieldName need at least one special character like !@#\$&*~-';
    }

    return null;
  }

  String? isPasswordConfirm(String? value, String password) {
    if (value?.isEmpty ?? true) return '$fieldName is required';

    if (value! != password) {
      return '$fieldName is not equal password';
    }

    return null;
  }
}

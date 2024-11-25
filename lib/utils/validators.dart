import '../constants/app_strings.dart';

class Validators {
  // Email validation
  static String? validateEmail(String value) {
    if (value.isEmpty) {
      return AppStrings.emailRequired;
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return AppStrings.invalidEmail;
    }
    return null;
  }

  // Password validation (e.g., minimum 6 characters)
  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return AppStrings.passwordRequired;
    }
    if (value.length < 6) {
      return AppStrings.passwordLength;
    }
    return null;
  }

  // First name validation (non-empty)
  static String? validateFirstName(String value) {
    if (value.isEmpty) {
      return 'First name is required';
    }
    return null;
  }

  // Last name validation (non-empty)
  static String? validateLastName(String value) {
    if (value.isEmpty) {
      return 'Last name is required';
    }
    return null;
  }

  // Generic field validation for non-empty fields
  static String? validateRequiredField(String value, String fieldName) {
    if (value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }
}

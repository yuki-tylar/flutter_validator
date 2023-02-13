library validator;
import 'package:flutter/material.dart';

class Validator {
  late ValidatorType type;
  String errorMessage;
  String? pattern;
  int min = 0;
  int max = 100000;
  TextEditingController? target;

  Validator.required({
    this.errorMessage = 'Required',
  }) {
    type = ValidatorType.required;
  }

  Validator.email({
    this.errorMessage = 'Invalid email',
  }) {
    type = ValidatorType.pattern;
    pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+$";
  }

  Validator.password({
    this.errorMessage = 'Invalid password',
    this.pattern =
        r'^(?=.*[A-Z])(?=.*\d)[a-zA-Z\d.!#$%&*+-/=?^_`{|}~\]\*\\]{8,}$',
  }) {
    type = ValidatorType.pattern;
  }

  Validator.integer({
    this.errorMessage = 'Invalid number',
  }) {
    type = ValidatorType.pattern;
    pattern = r'\d{1,}';
  }

  Validator.price({
    this.errorMessage = 'Invalid price',
    this.pattern = r'^\d{1,}(\.\d{1,2})?$',
  }) {
    type = ValidatorType.pattern;
  }

  Validator.minLength(
    minLength, {
    this.errorMessage = 'Too short',
  }) {
    type = ValidatorType.minLength;
    min = minLength;
  }
  Validator.maxLength(
    maxLength, {
    this.errorMessage = 'Too long',
  }) {
    type = ValidatorType.maxLength;
    max = maxLength;
  }

  Validator.min(
    this.min, {
    this.errorMessage = 'Select at least {min}',
  }) {
    type = ValidatorType.min;
    errorMessage = errorMessage.replaceAll('{min}', '$min');
  }

  Validator.max(
    this.max, {
    this.errorMessage = 'Select {max} or less',
  }) {
    type = ValidatorType.max;
    errorMessage = errorMessage.replaceAll('{max}', '$max');
  }

  Validator.match(
    this.target, {
    this.errorMessage = 'Not matched',
  }) {
    type = ValidatorType.match;
  }

  String? validate(dynamic value) {
    String? error;

    switch (type) {
      case ValidatorType.required:
        if (value == null) {
          error = errorMessage;
        } else if (value is! String) {
          error = null;
        } else if (value.isEmpty) {
          error = errorMessage;
        } else {
          error = null;
        }
        break;
      case ValidatorType.pattern:
        if (value == null) {
          error = null;
        } else if (value is! String) {
          error = errorMessage;
        } else if (RegExp(pattern!).hasMatch(value)) {
          error = null;
        } else {
          error = errorMessage;
        }
        break;
      case ValidatorType.minLength:
        if (value == null) {
          error = null;
        } else if (value is! String) {
          error =
              'validator error: Passed value type is ${value.runtimeType}. This type is not allowed to pass Validator.minLength';
        } else if (value.length < min) {
          error = errorMessage;
        } else {
          error = null;
        }
        break;
      case ValidatorType.maxLength:
        if (value == null) {
          error = null;
        } else if (value is! String) {
          error =
              'validator error: Passed value type is ${value.runtimeType}. This type is not allowed to pass Validator.maxLength';
        } else if (value.length > max) {
          error = errorMessage;
        } else {
          error = null;
        }
        break;

      case ValidatorType.min:
        if (value == null) {
          error = null;
        } else if (value is List) {
          if (value.length < min) {
            error = errorMessage;
          } else {
            error = null;
          }
        } else if (value is int || value is double) {
          if (value < min) {
            error = errorMessage;
          } else {
            error = null;
          }
        } else {
          error =
              'validator error: Passed value type is ${value.runtimeType}. This type is not allowed to pass Validator.min';
        }
        break;

      case ValidatorType.max:
        if (value == null) {
          error = null;
        } else if (value is List) {
          if (value.length > max) {
            error = errorMessage;
          } else {
            error = null;
          }
        } else if (value is int || value is double) {
          if (value > max) {
            error = errorMessage;
          } else {
            error = null;
          }
        } else {
          error =
              'validator error: Passed value type is ${value.runtimeType}. This type is not allowed to pass Validator.max';
        }
        break;

      case ValidatorType.match:
        if (value != target?.text) {
          error = errorMessage;
        } else {
          error = null;
        }
        break;
    }
    return error;
  }
}

enum ValidatorType {
  required,
  pattern,
  minLength,
  maxLength,
  min,
  max,
  match,
}

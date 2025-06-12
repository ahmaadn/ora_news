import 'package:flutter/material.dart';
import 'package:ora_news/app/utils/validators.dart';

class FieldValidatorBuilder {
  static final _uppercaseRegExpBuilder = RegExp(r'[A-Z]');
  static final _specialCharRegExpBuilder = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

  final List<FormFieldValidator<String>> _validators = [];
  final String _fieldName;

  FieldValidatorBuilder(this._fieldName);

  /// Menandakan bahwa field ini wajib diisi.
  FieldValidatorBuilder required({String? message}) {
    _validators.add(
      (value) => AppValidators.isEmpty(value, fieldName: _fieldName, message: message),
    );
    return this;
  }

  /// Memvalidasi panjang minimum string.
  FieldValidatorBuilder minLength(int min, {String? message}) {
    _validators.add(
      (value) =>
          AppValidators.minLength(value, min, fieldName: _fieldName, message: message),
    );
    return this;
  }

  /// Memvalidasi panjang maksimum string.
  FieldValidatorBuilder maxLength(int max, {String? message}) {
    _validators.add(
      (value) =>
          AppValidators.maxLength(value, max, fieldName: _fieldName, message: message),
    );
    return this;
  }

  /// Memvalidasi format email.
  FieldValidatorBuilder email({String? message}) {
    _validators.add((value) => AppValidators.isValidEmail(value, message: message));
    return this;
  }

  /// Memvalidasi apakah string mengandung setidaknya satu angka.
  FieldValidatorBuilder containsNumber({String? message}) {
    _validators.add((value) => AppValidators.containsNumber(value, message: message));
    return this;
  }

  /// Memvalidasi apakah string mengandung setidaknya satu huruf besar.
  FieldValidatorBuilder containsUppercase({String? message}) {
    _validators.add((value) {
      if (value != null && value.isNotEmpty && !value.contains(_uppercaseRegExpBuilder)) {
        return message ?? '$_fieldName harus mengandung huruf besar';
      }
      return null;
    });
    return this;
  }

  /// Memvalidasi apakah string mengandung setidaknya satu karakter spesial
  FieldValidatorBuilder containsSpecialCharacter({String? message}) {
    _validators.add((value) {
      if (value != null && value.isNotEmpty && !value.contains(_specialCharRegExpBuilder)) {
        return message ?? '$_fieldName harus mengandung karakter spesial';
      }
      return null;
    });
    return this;
  }

  /// Memvalidasi apakah nilai field sama dengan nilai dari field lain (misalnya, konfirmasi password).
  FieldValidatorBuilder mustMatch(
    String Function() otherValueCallback, {
    String? message,
    String otherFieldNameHint = 'konfirmasi',
  }) {
    _validators.add(
      (value) => AppValidators.mustMatch(
        value,
        otherValueCallback(),
        fieldName: _fieldName,
        message: message,
      ),
    );
    return this;
  }

  /// Menambahkan validator kustom.
  FieldValidatorBuilder custom(FormFieldValidator<String> validator) {
    _validators.add(validator);
    return this;
  }

  FormFieldValidator<String> build() => AppValidators.compose(_validators);
}

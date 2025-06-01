// lib/utils/validators.dart

import 'package:flutter/material.dart';

class AppValidators {
  static final _emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  static final _numberRegExp = RegExp(r'[0-9]');

  /// Menggabungkan beberapa validator menjadi satu.
  /// Akan mengembalikan pesan error dari validator pertama yang gagal.
  /// Jika semua validator lolos, akan mengembalikan null.
  static FormFieldValidator<String> compose(List<FormFieldValidator<String>> validators) {
    return (String? value) {
      for (final validator in validators) {
        final String? error = validator(value);
        if (error != null) {
          return error;
        }
      }
      return null;
    };
  }

  // Validator untuk memeriksa apakah field kosong.
  static String? isEmpty(String? value, {String fieldName = 'Field', String? message}) {
    if (value == null || value.isEmpty) {
      return message ?? '$fieldName tidak boleh kosong';
    }
    return null;
  }

  // Validator untuk memeriksa format email.
  static String? isValidEmail(String? value, {String? message}) {
    // Menggunakan RegExp yang sudah dikompilasi untuk efisiensi.
    if (value == null || !_emailRegExp.hasMatch(value)) {
      return message ?? 'Format email tidak valid';
    }
    return null;
  }

  // Validator untuk panjang minimum karakter.
  static String? minLength(
    String? value,
    int min, {
    String fieldName = 'Field',
    String? message,
  }) {
    if (value == null || value.length < min) {
      return message ?? '$fieldName minimal $min karakter';
    }
    return null;
  }

  // Validator untuk panjang minimum karakter.
  static String? maxLength(
    String? value,
    int min, {
    String fieldName = 'Field',
    String? message,
  }) {
    if (value == null || value.length > min) {
      return message ?? '$fieldName minimal $min karakter';
    }
    return null;
  }

  // Validator untuk memeriksa apakah mengandung angka.
  static String? containsNumber(String? value, {String? message}) {
    if (value == null || !_numberRegExp.hasMatch(value)) {
      return message ?? 'Harus mengandung setidaknya satu angka';
    }
    return null;
  }

  // Validator untuk mencocokkan dua nilai (misal: konfirmasi password).
  static String? mustMatch(
    String? value1,
    String? value2, {
    String fieldName = 'Field',
    String? message,
  }) {
    if (value1 != value2) {
      return message ?? '$fieldName tidak cocok';
    }
    return null;
  }
}

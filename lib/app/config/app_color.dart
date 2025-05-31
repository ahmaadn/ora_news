import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Warna Utama Aplikasi
  static const Color primary = Color(0xFFee484d);
  static const Color secondary = Color(0xFFfcce3d);

  // Warna Latar Belakang (Background Colors)
  static const Color background = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFFF0F0F0);

  // Warna untuk card, dialog, dll.
  static const Color surface = Color(0xFFFFFFFF);

  // Warna Teks (Text Colors)
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textLight = Color(0xFFFFFFFF);
  static const Color textDisabled = Color(0xFFBDBDBD);

  // Warna Status (Status Colors)
  static const Color success = Color(0xFF1dd75b);
  static const Color warning = Color(0xFFefb034);
  static const Color error = Color(0xFFde3b40);
  static const Color info = Color(0xFF379ae6);

  // Warna Netral (Neutral Colors)
  static const Color greyStrong = Color(0xFF565d6d);
  static const Color greyMedium = Color(0xFFbdc1ca);
  static const Color greyLight = Color(0xFFdee1e6);
  static const Color greyExtraLight = Color(0xFFf3f4f6);

  // Warna Basic
  static const Color white = Color(0xFFFFFFFF);
  static const Color neutral = Color(0xFF171a1f);
  static const Color black = Color(0x00000000);
  static const Color grey = Color(0xFF565d6d);

  static const Color grey100 = Color(0xFFF5F5F5); // Paling terang (mirip backgroundDark)
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0); // Abu-abu terang
  static const Color grey400 = Color(
    0xFFBDBDBD,
  ); // Abu-abu medium-terang (mirip textDisabled)
  static const Color grey500 = Color(0xFF9E9E9E); // Abu-abu medium
  static const Color grey600 = Color(
    0xFF757575,
  ); // Abu-abu medium-gelap (mirip textSecondary)
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242); // Abu-abu gelap
  static const Color grey900 = Color(0xFF212121); // Paling gelap (mirip textPrimary)
}

import 'package:flutter/material.dart';

class AppSpacing {
  // Private constructor agar kelas ini tidak bisa diinstansiasi.
  AppSpacing._();

  // Spacing Umum (General Spacing Values)
  // Ini adalah nilai-nilai dasar yang bisa dikombinasikan.
  static const double xxs = 2.0; // Extra extra small
  static const double xs = 4.0; // Extra small
  static const double s = 8.0; // Small
  static const double m = 16.0; // Medium
  static const double l = 24.0; // Large
  static const double xl = 32.0; // Extra large
  static const double xxl = 48.0; // Extra extra large
  static const double xxxl = 64.0; // Extra extra extra large

  // Horizontal
  static const Widget hsXXSmall = SizedBox(width: xxs);
  static const Widget hsXSmall = SizedBox(width: xs);
  static const Widget hsSmall = SizedBox(width: s);
  static const Widget hsMedium = SizedBox(width: m);
  static const Widget hsLarge = SizedBox(width: l);
  static const Widget hsXLarge = SizedBox(width: xl);
  static const Widget hsXXLarge = SizedBox(width: xxl);
  static const Widget hsXXXLarge = SizedBox(width: xxl);
  static const Widget hsMassive = SizedBox(width: 120.0);

  // Vertical
  static const Widget vsXXSmall = SizedBox(height: xxs);
  static const Widget vsXSmall = SizedBox(height: xs);
  static const Widget vsSmall = SizedBox(height: s);
  static const Widget vsMedium = SizedBox(height: m);
  static const Widget vsLarge = SizedBox(height: l);
  static const Widget vsXLarge = SizedBox(height: xl);
  static const Widget vsXXLarge = SizedBox(height: xxl);
  static const Widget vsXXXLarge = SizedBox(height: xxl);
  static const Widget vsMassive = SizedBox(height: 120.0);

  // Radius Sudut
  static const double roundedTiny = 2.0;
  static const double roundedSmall = 4.0;
  static const double roundedMedium = 6.0;
  static const double roundedLarge = 10.0;
  static const double roundedXLarge = 16.0;
  static const double roundedPill = 100.0;

  // Ukuran Ikon (Icon Sizes)
  static const double iconSmall = 16.0;
  static const double iconMedium = 24.0;
  static const double iconLarge = 32.0;

  // Tinggi Elemen (Element Heights)
  // Contoh: tinggi standar untuk tombol atau input field
  static const double buttonHeight = 48.0;
  static const double inputHeight = 56.0;

  // Divider
  static const double dividerThickness = 1.0;

  // Spacing Horizontal (Horizontal Padding/Margin)
  static const double horizontalPaddingPage = m;
  static const double horizontalMarginElement = s;
}

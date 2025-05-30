import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ora_news/app/config/app_color.dart';

class AppTypography {
  AppTypography._();

  // Family Font
  static final String fontFamilyPrimary = GoogleFonts.albertSans().fontFamily!;
  static final String fontFamilySecondary = GoogleFonts.roboto().fontFamily!;

  // Font weight
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;

  // Text Style Primary
  static TextStyle baseStyle({
    required double size,
    FontWeight weight = regular,
    Color? color,
    double letterSpacing = 0,
    double height = 1.5,
  }) => TextStyle(
    fontFamily: fontFamilyPrimary,
    fontSize: size,
    fontWeight: weight,
    color: color ?? AppColors.textPrimary,
    letterSpacing: letterSpacing,
    height: height,
  );

  // Title
  static final TextStyle title1 = baseStyle(size: 40, weight: bold, height: 1.4);
  static final TextStyle title2 = baseStyle(size: 32, weight: bold);
  static final TextStyle title3 = baseStyle(size: 24, weight: bold);

  // Headlines
  static final TextStyle headline1 = baseStyle(size: 20, weight: bold);
  static final TextStyle headline2 = baseStyle(size: 18, weight: bold);
  static final TextStyle headline3 = baseStyle(size: 16, weight: bold, height: 1.625);

  // Body Text
  static final TextStyle bodyText1 = baseStyle(size: 16, weight: regular);
  static final TextStyle bodyText2 = baseStyle(size: 14, weight: regular, height: 1.4);

  // Subtitles
  static final TextStyle subtitle1 = baseStyle(
    size: 16,
    weight: medium,
    letterSpacing: 0.15,
  );
  static final TextStyle subtitle2 = baseStyle(
    size: 14,
    weight: medium,
    color: AppColors.textSecondary,
    letterSpacing: 0.1,
  );

  // Button
  static final TextStyle button = baseStyle(
    size: 14,
    weight: semiBold,
    color: AppColors.textLight,
    letterSpacing: 1.25,
  );

  // Caption & Overline
  static final TextStyle caption = baseStyle(
    size: 12,
    color: AppColors.textSecondary,
    letterSpacing: 0.4,
  );
  static final TextStyle overline = baseStyle(
    size: 10,
    weight: FontWeight.w500,
    color: AppColors.textSecondary,
    letterSpacing: 1.5,
  ).copyWith(textBaseline: TextBaseline.alphabetic);
}

import 'package:flutter/material.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_spacing.dart';
import 'package:ora_news/app/config/app_typography.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.textLight, // Warna teks di atas primary
      secondary: AppColors.secondary,
      onSecondary: AppColors.textLight, // Warna teks di atas secondary
      error: AppColors.error,
      onError: AppColors.textLight,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
    ),
    scaffoldBackgroundColor: AppColors.background,
    fontFamily: AppTypography.fontFamilyPrimary, // Font default untuk aplikasi
    // Konfigurasi AppBar
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.textPrimary, // Warna ikon dan judul di AppBar
      titleTextStyle: AppTypography.headline2.copyWith(color: AppColors.textPrimary),
      iconTheme: const IconThemeData(
        color: AppColors.textLight,
        size: AppSpacing.iconMedium,
      ),
    ),

    // Konfigurasi Tombol
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textLight,
        textStyle: AppTypography.button,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.m,
          vertical: AppSpacing.s + AppSpacing.xs, // Sedikit lebih tinggi
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.roundedMedium),
        ),
        elevation: 2.0,
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        textStyle: AppTypography.button.copyWith(color: AppColors.primary),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary, width: 1.5),
        textStyle: AppTypography.button.copyWith(color: AppColors.primary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.roundedMedium),
        ),
      ),
    ),

    // Konfigurasi Input Decoration (untuk TextField)
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.greyExtraLight,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.m,
        vertical: AppSpacing.m,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.roundedMedium),
        borderSide: BorderSide.none, // Tidak ada border default
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.roundedMedium),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.roundedMedium),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.roundedMedium),
        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.roundedMedium),
        borderSide: const BorderSide(color: AppColors.error, width: 2.0),
      ),
      labelStyle: AppTypography.bodyText2.copyWith(color: AppColors.textSecondary),
      hintStyle: AppTypography.bodyText2.copyWith(color: AppColors.greyMedium),
    ),

    // Konfigurasi Card
    cardTheme: CardTheme(
      elevation: 2.0,
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.roundedMedium),
      ),
      margin: const EdgeInsets.all(AppSpacing.s),
    ),

    // Konfigurasi TextTheme
    textTheme: TextTheme(
      displayLarge: AppTypography.title1,
      displayMedium: AppTypography.title2,
      displaySmall: AppTypography.title3,

      headlineLarge: AppTypography.headline1,
      headlineMedium: AppTypography.headline2,
      headlineSmall: AppTypography.headline3,

      titleLarge: AppTypography.subtitle1,
      titleMedium: AppTypography.subtitle2,
      bodyLarge: AppTypography.bodyText1,
      bodyMedium: AppTypography.bodyText2,
      labelLarge: AppTypography.button.copyWith(color: AppColors.textPrimary),
      bodySmall: AppTypography.caption,
      labelSmall: AppTypography.overline,
    ),

    // Konfigurasi IconTheme
    iconTheme: const IconThemeData(
      color: AppColors.textPrimary, // Warna ikon default
      size: AppSpacing.iconMedium,
    ),

    // Konfigurasi DividerTheme
    dividerTheme: const DividerThemeData(
      color: AppColors.greyLight,
      thickness: AppSpacing.dividerThickness,
      space: AppSpacing.m, // Jarak total, setengah di atas, setengah di bawah
    ),
  );
}

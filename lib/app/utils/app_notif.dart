import 'package:flutter/material.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_spacing.dart';
import 'package:ora_news/app/config/app_typography.dart';

enum NotifType { info, success, warning, error }

class AppNotif {
  AppNotif._();

  /// Menampilkan notifikasi tipe info/biasa.
  static void info(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 4),
  }) {
    show(context, message: message, type: NotifType.info, duration: duration);
  }

  /// Menampilkan notifikasi tipe sukses (hijau).
  static void success(
    BuildContext context, {
    required String message,
    IconData? customIcon,
    Duration duration = const Duration(seconds: 4),
  }) {
    show(
      context,
      message: message,
      type: NotifType.success,
      customIcon: customIcon,
      duration: duration,
    );
  }

  /// Menampilkan notifikasi tipe peringatan (kuning).
  static void warning(
    BuildContext context, {
    required String message,
    IconData? customIcon,
    Duration duration = const Duration(seconds: 4),
  }) {
    show(
      context,
      message: message,
      type: NotifType.warning,
      customIcon: customIcon,
      duration: duration,
    );
  }

  /// Menampilkan notifikasi tipe error (merah).
  static void error(
    BuildContext context, {
    required String message,
    IconData? customIcon,
    Duration duration = const Duration(seconds: 4),
  }) {
    show(
      context,
      message: message,
      type: NotifType.error,
      customIcon: customIcon,
      duration: duration,
    );
  }

  /// Menampilkan SnackBar kustom.
  static void show(
    BuildContext context, {
    required String message,
    NotifType type = NotifType.info,
    IconData? customIcon,
    Duration duration = const Duration(seconds: 4),
  }) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    Color backgroundColor;
    Color foregroundColor;
    IconData defaultIcon;

    switch (type) {
      case NotifType.success:
        backgroundColor = AppColors.success;
        foregroundColor = AppColors.textLight;
        defaultIcon = Icons.check_circle_outline;
        break;
      case NotifType.warning:
        backgroundColor = AppColors.warning;
        foregroundColor = AppColors.textPrimary;
        defaultIcon = Icons.warning_amber_rounded;
        break;
      case NotifType.error:
        backgroundColor = AppColors.error;
        foregroundColor = AppColors.textLight;
        defaultIcon = Icons.error_outline;
        break;
      case NotifType.info:
        backgroundColor = AppColors.grey700;
        foregroundColor = AppColors.textLight;
        defaultIcon = Icons.info_outline;
        break;
    }

    final bool hasIcon = customIcon != null || type != NotifType.info;
    final IconData? iconToShow =
        customIcon ?? (type != NotifType.info ? defaultIcon : null);

    final snackBarContent = Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m, vertical: AppSpacing.s),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppSpacing.roundedMedium),
      ),
      child: Row(
        children: [
          if (hasIcon && iconToShow != null) ...[
            Icon(iconToShow, color: foregroundColor, size: AppSpacing.iconMedium),
            AppSpacing.hsMedium,
          ],
          Expanded(
            child: Text(
              message,
              style: AppTypography.bodyText2.copyWith(color: foregroundColor),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: hasIcon ? TextAlign.left : TextAlign.center,
            ),
          ),
        ],
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: snackBarContent,
        backgroundColor: Colors.transparent,
        elevation: 0,

        behavior: SnackBarBehavior.floating,

        margin: const EdgeInsets.only(bottom: AppSpacing.l),
        duration: duration,
      ),
    );
  }
}

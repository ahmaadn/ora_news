import 'package:flutter/material.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_spacing.dart';
import 'package:ora_news/app/config/app_typography.dart';

// Enum untuk berbagai jenis tombol
enum CustomButtonType { solid, outline, ghost, link }

// Enum untuk bentuk tombol
enum CustomButtonShape { rectangle, rounded, pill, circular }

// Enum untuk posisi ikon
enum IconPosition { leading, trailing }

// Enum untuk ukuran tinggi tombol berdasarkan AppSpacing.box*
enum CustomButtonSize { xSmall, small, medium, large, xLarge }

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  final Widget? icon;
  final CustomButtonType buttonType;
  final CustomButtonShape buttonShape;
  final IconPosition iconPosition;
  final CustomButtonSize buttonSize;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? outlineColor;
  final bool isDisabled;
  final bool isLoading;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final double? elevation;

  const CustomButton({
    super.key,
    required this.onPressed,
    this.text,
    this.icon,
    this.buttonType = CustomButtonType.solid,
    this.buttonShape = CustomButtonShape.rounded,
    this.iconPosition = IconPosition.leading,
    this.buttonSize = CustomButtonSize.medium, // Default ukuran medium
    this.backgroundColor,
    this.foregroundColor,
    this.outlineColor,
    this.isDisabled = false,
    this.isLoading = false,
    this.width,
    this.padding,
    this.elevation,
  }) : assert(text != null || icon != null, 'Button must have either text or icon or both');

  double get _effectiveHeight {
    switch (buttonSize) {
      case CustomButtonSize.xSmall:
        return AppSpacing.boxXSmall;
      case CustomButtonSize.small:
        return AppSpacing.boxSmall;
      case CustomButtonSize.medium:
        return AppSpacing.boxMedium;
      case CustomButtonSize.large:
        return AppSpacing.boxLarge;
      case CustomButtonSize.xLarge:
        return AppSpacing.boxXLarge;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool effectiveIsDisabled = isDisabled || isLoading || onPressed == null;
    final VoidCallback? effectiveOnPressed = effectiveIsDisabled ? null : onPressed;

    // Menentukan warna berdasarkan tipe dan status
    Color bgColor = backgroundColor ?? _getBackgroundColor(context);
    Color fgColor = foregroundColor ?? _getForegroundColor(context, bgColor);
    Color brdColor = outlineColor ?? _getOutlineColor(context, fgColor);

    if (effectiveIsDisabled) {
      bgColor = _getDisabledBackgroundColor(context, bgColor);
      fgColor = _getDisabledForegroundColor(context, fgColor);
      brdColor = _getDisabledOutlineColor(context, brdColor);
    }

    Widget buttonChild =
        isLoading
            ? SizedBox(
              width: AppSpacing.iconMedium,
              height: AppSpacing.iconMedium,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                valueColor: AlwaysStoppedAnimation<Color>(fgColor),
              ),
            )
            : _buildButtonChild(fgColor);

    final EdgeInsetsGeometry effectivePadding = padding ?? _getDefaultPadding();
    final OutlinedBorder shape = _getButtonShape(brdColor);

    switch (buttonType) {
      case CustomButtonType.outline:
        return SizedBox(
          width: width,
          height: _effectiveHeight,
          child: OutlinedButton(
            onPressed: effectiveOnPressed,
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.transparent, // Selalu transparan untuk outline
              foregroundColor: fgColor,
              side: BorderSide(color: brdColor, width: 1.5),
              shape: shape,
              padding: effectivePadding,
              elevation: elevation ?? 0,
            ).copyWith(
              overlayColor: WidgetStateProperty.resolveWith<Color?>((
                Set<WidgetState> states,
              ) {
                if (states.contains(WidgetState.pressed)) {
                  return fgColor.withValues(alpha: .12);
                }
                return null;
              }),
            ),
            child: buttonChild,
          ),
        );
      case CustomButtonType.solid:
        return SizedBox(
          width: width,
          height: _effectiveHeight,
          child: ElevatedButton(
            onPressed: effectiveOnPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: bgColor,
              foregroundColor: fgColor,
              shape: shape,
              padding: effectivePadding,
              elevation: elevation ?? 2.0,
            ),
            child: buttonChild,
          ),
        );
      case CustomButtonType.ghost:
      case CustomButtonType.link:
        return SizedBox(
          width: width,
          height: _effectiveHeight,
          child: TextButton(
            onPressed: effectiveOnPressed,
            style: TextButton.styleFrom(
              backgroundColor: Colors.transparent, // Selalu transparan untuk ghost/link
              foregroundColor: fgColor,
              padding: effectivePadding,
              shape: shape,
              textStyle:
                  buttonType == CustomButtonType.link
                      ? AppTypography.bodyText2.copyWith(
                        color: fgColor,
                        decoration: TextDecoration.underline,
                        decorationColor: fgColor,
                        fontWeight: AppTypography.medium,
                      )
                      : AppTypography.button.copyWith(color: fgColor),
            ).copyWith(
              overlayColor: WidgetStateProperty.resolveWith<Color?>((
                Set<WidgetState> states,
              ) {
                if (states.contains(WidgetState.pressed)) {
                  return fgColor.withValues(alpha: .12);
                }
                return null;
              }),
            ),
            child: buttonChild,
          ),
        );
    }
  }

  Widget _buildButtonChild(Color effectiveFgColor) {
    TextStyle buttonTextStyle = AppTypography.button.copyWith(color: effectiveFgColor);
    // Untuk link, gunakan style teks yang berbeda jika ada teks
    if (buttonType == CustomButtonType.link && text != null) {
      buttonTextStyle = AppTypography.bodyText2.copyWith(
        color: effectiveFgColor,
        fontWeight: AppTypography.medium,
        // Dekorasi underline sudah dihandle di TextButton.styleFrom
      );
    }

    if (icon != null && text != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            iconPosition == IconPosition.leading
                ? [
                  IconTheme(
                    data: IconThemeData(
                      color: effectiveFgColor,
                      size: AppSpacing.iconSmall,
                    ),
                    child: icon!,
                  ),
                  AppSpacing.hsSmall, // Menggunakan SizedBox dari AppSpacing
                  Text(text!, style: buttonTextStyle),
                ]
                : [
                  Text(text!, style: buttonTextStyle),
                  AppSpacing.hsSmall, // Menggunakan SizedBox dari AppSpacing
                  IconTheme(
                    data: IconThemeData(
                      color: effectiveFgColor,
                      size: AppSpacing.iconSmall,
                    ),
                    child: icon!,
                  ),
                ],
      );
    } else if (text != null) {
      return Text(text!, style: buttonTextStyle, textAlign: TextAlign.center);
    } else if (icon != null) {
      return IconTheme(
        data: IconThemeData(color: effectiveFgColor, size: AppSpacing.iconMedium),
        child: icon!,
      );
    }
    return const SizedBox.shrink();
  }

  EdgeInsetsGeometry _getDefaultPadding() {
    // Padding disesuaikan dengan tinggi tombol untuk konsistensi
    double verticalPadding;
    switch (buttonSize) {
      case CustomButtonSize.xSmall:
        verticalPadding = AppSpacing.xs / 2;
        break;
      case CustomButtonSize.small:
        verticalPadding = AppSpacing.s / 2;
        break;
      case CustomButtonSize.medium:
        verticalPadding = AppSpacing.s;
        break;
      case CustomButtonSize.large:
        verticalPadding = AppSpacing.s + AppSpacing.xs;
        break;
      case CustomButtonSize.xLarge:
        verticalPadding = AppSpacing.m;
        break;
    }

    if (buttonShape == CustomButtonShape.circular && icon != null && text == null) {
      return EdgeInsets.all(_effectiveHeight * 0.25);
    }
    if (icon != null && text != null) {
      return EdgeInsets.symmetric(horizontal: AppSpacing.m, vertical: verticalPadding);
    } else if (text != null) {
      return EdgeInsets.symmetric(horizontal: AppSpacing.l, vertical: verticalPadding);
    } else if (icon != null) {
      return EdgeInsets.all(verticalPadding);
    }
    return EdgeInsets.symmetric(horizontal: AppSpacing.m, vertical: verticalPadding);
  }

  OutlinedBorder _getButtonShape(Color borderColor) {
    switch (buttonShape) {
      case CustomButtonShape.rectangle:
        return const RoundedRectangleBorder(borderRadius: BorderRadius.zero);
      case CustomButtonShape.rounded:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.roundedMedium),
        );
      case CustomButtonShape.pill:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_effectiveHeight / 2),
        );
      case CustomButtonShape.circular:
        return const CircleBorder();
    }
  }

  // --- Helper untuk menentukan warna default ---
  Color _getBackgroundColor(BuildContext context) {
    // Dipanggil HANYA jika this.backgroundColor adalah null
    switch (buttonType) {
      case CustomButtonType.solid:
        return AppColors.neutral; // Warna latar default netral (abu-abu gelap)
      case CustomButtonType.outline:
      case CustomButtonType.ghost:
      case CustomButtonType.link:
        return Colors.transparent; // Tipe ini tidak memiliki latar belakang default
    }
  }

  Color _getForegroundColor(BuildContext context, Color currentBgColor) {
    // Dipanggil HANYA jika this.foregroundColor adalah null
    switch (buttonType) {
      case CustomButtonType.solid:
        // Jika latar belakang adalah default netral (grey700), teksnya putih/terang
        if (currentBgColor == AppColors.neutral) {
          return AppColors.textLight;
        }
        // Jika latar belakangnya custom (bukan grey700), coba gunakan onPrimary dari tema
        // atau fallback ke warna kontras lainnya. Ini adalah kasus yang lebih kompleks
        // jika ingin otomatis menentukan warna teks yang kontras untuk BG custom.
        // Untuk sekarang, jika BG custom, sebaiknya foregroundColor juga dispesifikkan.
        // Jika tidak, kita bisa fallback ke onSurface atau primary dari tema.
        // Namun, karena kita sudah punya this.foregroundColor di atas, ini lebih ke fallback.
        return Theme.of(context).colorScheme.onSurface; // Fallback jika BG custom
      case CustomButtonType.outline:
      case CustomButtonType.ghost:
        return AppColors.textPrimary; // Warna default netral (hitam/abu-abu gelap)
      case CustomButtonType.link:
        return AppColors.info; // Link tetap menggunakan warna info/aksen
    }
  }

  Color _getOutlineColor(BuildContext context, Color currentFgColor) {
    // Dipanggil HANYA jika this.outlineColor adalah null
    if (buttonType == CustomButtonType.outline) {
      // Warna outline default sama dengan warna foreground default untuk outline
      return currentFgColor; // Yang mana adalah AppColors.textPrimary dari _getForegroundColor
    }
    return Colors.transparent;
  }

  // --- Warna untuk status disabled ---
  Color _getDisabledBackgroundColor(BuildContext context, Color currentBgColor) {
    if (buttonType == CustomButtonType.solid) {
      return AppColors.greyLight;
    }
    return Colors.transparent;
  }

  Color _getDisabledForegroundColor(BuildContext context, Color currentFgColor) {
    return AppColors.greyStrong;
  }

  Color _getDisabledOutlineColor(BuildContext context, Color currentBorderColor) {
    if (buttonType == CustomButtonType.outline) {
      return AppColors.greyMedium;
    }
    return Colors.transparent;
  }
}

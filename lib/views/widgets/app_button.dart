import 'package:flutter/material.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_spacing.dart';
import 'custom_button.dart';

// --- Primary Button (Solid) ---
class PrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  final Widget? icon;
  final CustomButtonShape buttonShape;
  final IconPosition iconPosition;
  final CustomButtonSize buttonSize;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool isDisabled;
  final bool isLoading;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final double? elevation;

  const PrimaryButton({
    super.key,
    required this.onPressed,
    this.text,
    this.icon,
    this.buttonShape = CustomButtonShape.rounded,
    this.iconPosition = IconPosition.leading,
    this.buttonSize = CustomButtonSize.medium,
    this.backgroundColor,
    this.foregroundColor,
    this.isDisabled = false,
    this.isLoading = false,
    this.width,
    this.padding,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: onPressed,
      text: text,
      icon: icon,
      buttonType: CustomButtonType.solid,
      buttonShape: buttonShape,
      iconPosition: iconPosition,
      buttonSize: buttonSize,
      backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primary,
      foregroundColor: foregroundColor ?? Theme.of(context).colorScheme.onPrimary,
      isDisabled: isDisabled,
      isLoading: isLoading,
      width: width,
      padding: padding,
      elevation: elevation,
    );
  }
}

// --- Outline Button ---
class OutlineButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  final Widget? icon;
  final CustomButtonShape buttonShape;
  final IconPosition iconPosition;
  final CustomButtonSize buttonSize;
  final Color? foregroundColor; // Warna teks, ikon, dan border
  final Color? outlineColor; // Bisa override warna border jika berbeda dari foregroundColor
  final bool isDisabled;
  final bool isLoading;
  final double? width;
  final EdgeInsetsGeometry? padding;

  const OutlineButtonWidget({
    super.key,
    required this.onPressed,
    this.text,
    this.icon,
    this.buttonShape = CustomButtonShape.rounded,
    this.iconPosition = IconPosition.leading,
    this.buttonSize = CustomButtonSize.medium,
    this.foregroundColor,
    this.outlineColor,
    this.isDisabled = false,
    this.isLoading = false,
    this.width,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final Color defaultFgColor = Theme.of(context).colorScheme.primary;

    return CustomButton(
      onPressed: onPressed,
      text: text,
      icon: icon,
      buttonType: CustomButtonType.outline,
      buttonShape: buttonShape,
      iconPosition: iconPosition,
      buttonSize: buttonSize,
      foregroundColor: foregroundColor ?? defaultFgColor,
      outlineColor: outlineColor ?? foregroundColor ?? defaultFgColor,
      backgroundColor: Colors.transparent,
      isDisabled: isDisabled,
      isLoading: isLoading,
      width: width,
      padding: padding,
      elevation: 0,
    );
  }
}

// --- Ghost Button ---
class GhostButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  final Widget? icon;
  final CustomButtonShape buttonShape;
  final IconPosition iconPosition;
  final CustomButtonSize buttonSize;
  final Color? foregroundColor;
  final bool isDisabled;
  final bool isLoading;
  final double? width;
  final EdgeInsetsGeometry? padding;

  const GhostButton({
    super.key,
    required this.onPressed,
    this.text,
    this.icon,
    this.buttonShape = CustomButtonShape.rounded,
    this.iconPosition = IconPosition.leading,
    this.buttonSize = CustomButtonSize.medium,
    this.foregroundColor,
    this.isDisabled = false,
    this.isLoading = false,
    this.width,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: onPressed,
      text: text,
      icon: icon,
      buttonType: CustomButtonType.ghost,
      buttonShape: buttonShape,
      iconPosition: iconPosition,
      buttonSize: buttonSize,
      foregroundColor: foregroundColor ?? Theme.of(context).colorScheme.primary,
      backgroundColor: Colors.transparent,
      isDisabled: isDisabled,
      isLoading: isLoading,
      width: width,
      padding: padding,
      elevation: 0,
    );
  }
}

// --- Link Button ---
class LinkButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Widget? icon;
  final IconPosition iconPosition;
  final CustomButtonSize buttonSize;
  final Color? foregroundColor;
  final bool isDisabled;
  final bool isLoading;
  final double? width;
  final EdgeInsetsGeometry? padding;

  const LinkButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.iconPosition = IconPosition.leading,
    this.buttonSize = CustomButtonSize.medium,
    this.foregroundColor,
    this.isDisabled = false,
    this.isLoading = false,
    this.width,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: onPressed,
      text: text,
      icon: icon,
      buttonType: CustomButtonType.link,
      buttonShape: CustomButtonShape.rectangle,
      iconPosition: iconPosition,
      buttonSize: buttonSize,
      foregroundColor: foregroundColor ?? AppColors.info,
      backgroundColor: Colors.transparent,
      isDisabled: isDisabled,
      isLoading: isLoading,
      width: width,
      padding:
          padding ??
          const EdgeInsets.symmetric(
            horizontal: AppSpacing.xs,
            vertical: AppSpacing.xs / 2,
          ),
      elevation: 0,
    );
  }
}

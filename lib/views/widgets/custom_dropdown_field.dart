import 'package:flutter/material.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_spacing.dart';
import 'package:ora_news/app/config/app_typography.dart';

enum DropdownFieldSize { xSmall, small, medium, large, xLarge }

class CustomDropdownField<T> extends StatelessWidget {
  final String? hintText;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final FormFieldValidator<T>? validator;
  final DropdownFieldSize boxSize;

  const CustomDropdownField({
    super.key,
    this.hintText,
    required this.items,
    this.value,
    required this.onChanged,
    this.validator,
    this.boxSize = DropdownFieldSize.large,
  });

  double _getTargetBoxHeight() {
    switch (boxSize) {
      case DropdownFieldSize.xSmall:
        return AppSpacing.boxXSmall;
      case DropdownFieldSize.small:
        return AppSpacing.boxSmall;
      case DropdownFieldSize.medium:
        return AppSpacing.boxMedium;
      case DropdownFieldSize.large:
        return AppSpacing.boxLarge;
      case DropdownFieldSize.xLarge:
        return AppSpacing.boxXLarge;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _getTargetBoxHeight(),
      child: DropdownButtonFormField<T>(
        value: value,
        items: items,
        onChanged: onChanged,
        validator: validator,
        style: AppTypography.bodyText1.copyWith(color: AppColors.textPrimary),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTypography.bodyText1.copyWith(color: AppColors.textSecondary),
          contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.m, vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.roundedMedium),
            borderSide: const BorderSide(color: AppColors.grey400),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.roundedMedium),
            borderSide: const BorderSide(color: AppColors.grey400),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.roundedMedium),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.roundedMedium),
            borderSide: const BorderSide(color: AppColors.error, width: 1.5),
          ),
        ),
        icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.grey600),
      ),
    );
  }
}

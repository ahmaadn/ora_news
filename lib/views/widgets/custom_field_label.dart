import 'package:flutter/material.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_spacing.dart';
import 'package:ora_news/app/config/app_typography.dart';

class CustomFieldLabel extends StatelessWidget {
  final String text;
  final bool enabled;

  const CustomFieldLabel({super.key, required this.text, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: AppSpacing.s / 2,
      ), // Jarak 4.0 ke field di bawahnya
      child: Text(
        text,
        style: AppTypography.subtitle2.copyWith(
          color: enabled ? AppColors.textPrimary : AppColors.grey500,
        ),
      ),
    );
  }
}

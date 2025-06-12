import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_spacing.dart';
import 'package:ora_news/app/config/app_typography.dart';

class HeaderPage extends StatelessWidget {
  final String title;

  const HeaderPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppTypography.title1.copyWith(color: AppColors.textPrimary),
        ),
        AppSpacing.vsXLarge,
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
            children: <TextSpan>[
              const TextSpan(text: 'By continuing, you agree to our '),
              TextSpan(
                text: 'Terms of Services',
                style: AppTypography.caption.copyWith(
                  color: AppColors.info, // Warna link biru
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.info,
                ),
                recognizer:
                    TapGestureRecognizer()
                      ..onTap = () {
                        log('Navigate to Terms of Services');
                      },
              ),
              const TextSpan(text: ' and '),
              TextSpan(
                text: 'Private Policy',
                style: AppTypography.caption.copyWith(
                  color: AppColors.info, // Warna link biru
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.info,
                ),
                recognizer:
                    TapGestureRecognizer()
                      ..onTap = () {
                        log('Navigate to Private Policy');
                      },
              ),
              const TextSpan(text: '.'),
            ],
          ),
        ),
      ],
    );
  }
}

// d:\Dev\Praktikum Pemograman Mobile\ora_news\lib\views\features\auth\widgets\signin_bottom_actions.dart
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_spacing.dart';
import 'package:ora_news/app/config/app_typography.dart';
import 'package:ora_news/views/widgets/app_button.dart';

class SignInBottomActions extends StatelessWidget {
  final VoidCallback onContinuePressed;
  final VoidCallback onRegisterPressed;

  const SignInBottomActions({
    super.key,
    required this.onContinuePressed,
    required this.onRegisterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryButton(
          onPressed: onContinuePressed,
          text: 'Continue',
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textLight,
          width: double.infinity,
        ),
        AppSpacing.vsMedium,
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: AppTypography.bodyText2.copyWith(color: AppColors.textSecondary),
            children: <TextSpan>[
              const TextSpan(text: "Don't have an account? "),
              TextSpan(
                text: 'Register',
                style: AppTypography.bodyText2.copyWith(
                  color: AppColors.primary,
                  fontWeight: AppTypography.semiBold,
                ),
                recognizer: TapGestureRecognizer()..onTap = onRegisterPressed,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_spacing.dart';
import 'package:ora_news/app/config/app_typography.dart';
import 'package:ora_news/views/widgets/app_button.dart';
import 'package:ora_news/views/widgets/custom_button.dart';

class SignUpButtonAction extends StatelessWidget {
  final VoidCallback onPressed;
  final VoidCallback onLoginPressed;

  const SignUpButtonAction({
    super.key,
    required this.onPressed,
    required this.onLoginPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryButton(
          onPressed: onPressed,
          text: "Continue",
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textLight,
          buttonSize: CustomButtonSize.medium,
          width: double.infinity,
        ),
        AppSpacing.vsMedium,
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: AppTypography.bodyText2.copyWith(color: AppColors.textSecondary),
            children: <TextSpan>[
              const TextSpan(text: "Already have an account? "),
              TextSpan(
                text: 'Login',
                style: AppTypography.bodyText2.copyWith(
                  color: AppColors.primary,
                  fontWeight: AppTypography.semiBold,
                ),
                recognizer: TapGestureRecognizer()..onTap = onLoginPressed,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

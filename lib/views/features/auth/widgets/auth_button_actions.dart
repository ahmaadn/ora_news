import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_spacing.dart';
import 'package:ora_news/app/config/app_typography.dart';
import 'package:ora_news/views/widgets/app_button.dart';
import 'package:ora_news/views/widgets/custom_button.dart';

class AuthButtonActions extends StatelessWidget {
  final VoidCallback onPrimaryPressed;
  final VoidCallback onSecondaryPressed;
  final String primaryButtonText;
  final String questionText;
  final String secondaryButtonText;
  final Color backgroundColor;
  final Color foregroundColor;
  final double width;
  final CustomButtonSize buttonSize;
  const AuthButtonActions({
    super.key,
    required this.onPrimaryPressed,
    required this.onSecondaryPressed,
    required this.primaryButtonText,
    required this.questionText,
    required this.secondaryButtonText,
    this.backgroundColor = AppColors.primary,
    this.foregroundColor = AppColors.textLight,
    this.width = double.infinity,
    this.buttonSize = CustomButtonSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryButton(
          onPressed: onPrimaryPressed,
          text: primaryButtonText,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          buttonSize: buttonSize,
          width: width,
        ),
        AppSpacing.vsMedium,
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: AppTypography.bodyText2.copyWith(color: AppColors.textSecondary),
            children: <TextSpan>[
              TextSpan(text: "$questionText "),
              TextSpan(
                text: secondaryButtonText,
                style: AppTypography.bodyText2.copyWith(
                  color: AppColors.primary,
                  fontWeight: AppTypography.semiBold,
                ),
                recognizer: TapGestureRecognizer()..onTap = onSecondaryPressed,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Factory constructors for specific use cases
  factory AuthButtonActions.signUp({
    required VoidCallback onContinuePressed,
    required VoidCallback onLoginPressed,
  }) {
    return AuthButtonActions(
      onPrimaryPressed: onContinuePressed,
      onSecondaryPressed: onLoginPressed,
      primaryButtonText: 'Continue',
      questionText: 'Already have an account?',
      secondaryButtonText: 'Login',
    );
  }

  factory AuthButtonActions.signIn({
    required VoidCallback onContinuePressed,
    required VoidCallback onRegisterPressed,
  }) {
    return AuthButtonActions(
      onPrimaryPressed: onContinuePressed,
      onSecondaryPressed: onRegisterPressed,
      primaryButtonText: 'Continue',
      questionText: "Don't have an account?",
      secondaryButtonText: 'Register',
    );
  }

  factory AuthButtonActions.forgotPassword({
    required VoidCallback onContinuePressed,
    required VoidCallback onLoginPressed,
  }) {
    return AuthButtonActions(
      onPrimaryPressed: onContinuePressed,
      onSecondaryPressed: onLoginPressed,
      primaryButtonText: 'Continue',
      questionText: "Already have an account?",
      secondaryButtonText: 'Login',
    );
  }
}

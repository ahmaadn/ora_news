import 'package:flutter/material.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_spacing.dart';
import 'package:ora_news/app/config/app_typography.dart';
import 'package:ora_news/app/utils/field_validator_builder.dart';
import 'package:ora_news/views/widgets/custom_form_field.dart';

class SignInForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final VoidCallback onTogglePasswordVisibility;
  final VoidCallback onForgotPassword;

  const SignInForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.obscurePassword,
    required this.onTogglePasswordVisibility,
    required this.onForgotPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomFormField(
            controller: emailController,
            labelText: 'Email or phone number',
            hintText: 'Enter your email or phone number',
            keyboardType: TextInputType.emailAddress,
            validator: FieldValidatorBuilder('Email').required().email().build(),
            textInputAction: TextInputAction.next,
            collapseError: false,
          ),
          AppSpacing.vsSmall,
          CustomFormField(
            controller: passwordController,
            labelText: 'Password',
            hintText: 'Enter your password',
            obscureText: obscurePassword,
            collapseError: false,
            suffixIcon: IconButton(
              icon: Icon(
                obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                color: AppColors.grey500,
              ),
              onPressed: onTogglePasswordVisibility,
            ),
            validator: FieldValidatorBuilder("Password").required().minLength(6).build(),
            textInputAction: TextInputAction.done,
          ),
          AppSpacing.vsSmall,
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: onForgotPassword,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSpacing.xs / 2,
                  horizontal: AppSpacing.xs,
                ),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Forgot password?',
                style: AppTypography.caption.copyWith(
                  color: AppColors.info,
                  fontWeight: AppTypography.medium,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

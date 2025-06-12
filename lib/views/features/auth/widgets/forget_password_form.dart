import 'package:flutter/material.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_spacing.dart';
import 'package:ora_news/app/utils/field_validator_builder.dart';
import 'package:ora_news/views/widgets/custom_form_field.dart';

class ForgetPasswordForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;

  final VoidCallback onTogglePasswordVisibility;

  final bool obscureNewPassword;

  const ForgetPasswordForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.newPasswordController,
    required this.confirmPasswordController,
    required this.onTogglePasswordVisibility,
    required this.obscureNewPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomFormField(
            controller: emailController,
            labelText: 'Email',
            hintText: 'Enter your email',
            keyboardType: TextInputType.emailAddress,
            boxSize: FormFieldSize.large,
            validator: FieldValidatorBuilder('Email').required().email().build(),
            textInputAction: TextInputAction.next,
            collapseError: false,
          ),
          AppSpacing.vsSmall,
          CustomFormField(
            controller: newPasswordController,
            labelText: 'New Password',
            hintText: 'Enter new password',
            obscureText: obscureNewPassword,
            boxSize: FormFieldSize.large,
            suffixIcon: IconButton(
              icon: Icon(
                obscureNewPassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: AppColors.grey500,
              ),
              onPressed: onTogglePasswordVisibility,
            ),
            validator:
                FieldValidatorBuilder(
                  'Password',
                ).required().minLength(8).containsNumber().build(),
            textInputAction: TextInputAction.next,
            collapseError: false,
          ),
          AppSpacing.vsSmall,
          CustomFormField(
            controller: confirmPasswordController,
            labelText: 'Confirmation new Password',
            hintText: 'Confirm your new password',
            obscureText: true,
            boxSize: FormFieldSize.large,
            validator:
                FieldValidatorBuilder('Confirmation Password')
                    .required()
                    .mustMatch(
                      () => newPasswordController.text,
                      otherFieldNameHint: 'Password',
                    )
                    .build(),
            textInputAction: TextInputAction.done,
            collapseError: false,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_spacing.dart';
import 'package:ora_news/app/utils/field_validator_builder.dart';
import 'package:ora_news/views/widgets/custom_form_field.dart';

class RegisterForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool obscurePassword;
  final VoidCallback onTogglePasswordVisibility;
  final VoidCallback onSubmitForm;

  const RegisterForm({
    super.key,
    required this.formKey,
    required this.fullNameController,
    required this.emailController,
    required this.phoneNumberController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.obscurePassword,
    required this.onTogglePasswordVisibility,
    required this.onSubmitForm,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomFormField(
            controller: fullNameController,
            labelText: "Full Name",
            hintText: 'Your full name',
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            validator: FieldValidatorBuilder('Full Name').required().minLength(3).build(),
            textInputAction: TextInputAction.next,
            collapseError: false,
            boxSize: FormFieldSize.large,
          ),
          AppSpacing.vsSmall,
          CustomFormField(
            controller: emailController,
            labelText: 'Email',
            hintText: 'Your email address',
            keyboardType: TextInputType.emailAddress,
            validator: FieldValidatorBuilder('Email').required().email().build(),
            textInputAction: TextInputAction.next,
            collapseError: false,
            boxSize: FormFieldSize.large,
          ),
          AppSpacing.vsSmall,
          CustomFormField(
            controller: phoneNumberController,
            labelText: "Phone Number",
            hintText: 'Your phone number',
            keyboardType: TextInputType.phone,
            validator:
                FieldValidatorBuilder('Phone Number').required().minLength(8).build(),
            textInputAction: TextInputAction.next,
            collapseError: false,
            boxSize: FormFieldSize.large,
          ),
          AppSpacing.vsSmall,
          CustomFormField(
            controller: passwordController,
            labelText: "Password",
            hintText: 'Create a strong password',
            obscureText: obscurePassword,
            suffixIcon: IconButton(
              icon: Icon(
                obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                color: AppColors.grey500,
              ),
              onPressed: onTogglePasswordVisibility,
            ),
            validator:
                FieldValidatorBuilder(
                  'Password',
                ).required().minLength(8).containsNumber().containsUppercase().build(),
            textInputAction: TextInputAction.next,
            collapseError: false,
            boxSize: FormFieldSize.large,
          ),
          AppSpacing.vsSmall,
          CustomFormField(
            controller: confirmPasswordController,
            labelText: "Confirmation Password",
            hintText: 'Confirm your password',
            obscureText: true,
            validator:
                FieldValidatorBuilder('Confirmation Password')
                    .required()
                    .mustMatch(
                      () => passwordController.text,
                      otherFieldNameHint: 'Password',
                    )
                    .build(),
            textInputAction: TextInputAction.done,
            collapseError: false,
            boxSize: FormFieldSize.large,
          ),
        ],
      ),
    );
  }
}

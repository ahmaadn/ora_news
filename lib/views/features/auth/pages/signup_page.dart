import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_spacing.dart';
import 'package:ora_news/app/constants/route_names.dart';
import 'package:ora_news/views/features/auth/widgets/auth_button_actions.dart';
import 'package:ora_news/views/features/auth/widgets/header_page.dart';
import 'package:ora_news/views/features/auth/widgets/signup_form.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Proses sign up di sini
      String fullName = _fullNameController.text;
      String email = _emailController.text;
      String phoneNumber = _phoneNumberController.text;
      String password = _passwordController.text;
      log('Full Name: $fullName, Email: $email, Phone: $phoneNumber, Password: $password');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Processing Sign Up...')));
    }
  }

  void _navigateToLogin() {
    log('Navigate to Login Screen');
    context.goNamed(RouteNames.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.m * 1.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    HeaderPage(title: "Sign Up"),
                    AppSpacing.vsXLarge,
                    SignUpForm(
                      formKey: _formKey,
                      fullNameController: _fullNameController,
                      emailController: _emailController,
                      phoneNumberController: _phoneNumberController,
                      passwordController: _passwordController,
                      confirmPasswordController: _confirmPasswordController,
                      obscurePassword: _obscurePassword,
                      onTogglePasswordVisibility: _togglePasswordVisibility,
                      onSubmitForm: _submitForm,
                    ),
                    AppSpacing.vsLarge,
                    AuthButtonActions.signUp(
                      onContinuePressed: _submitForm,
                      onLoginPressed: _navigateToLogin,
                    ),
                    AppSpacing.vsMedium,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

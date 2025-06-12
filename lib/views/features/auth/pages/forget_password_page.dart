import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_spacing.dart';

import 'package:ora_news/app/constants/route_names.dart';

import 'package:ora_news/views/features/auth/widgets/auth_button_actions.dart';
import 'package:ora_news/views/features/auth/widgets/forget_password_form.dart';
import 'package:ora_news/views/features/auth/widgets/header_page.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureNewPassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _toggleNewPasswordVisibility() {
    setState(() {
      _obscureNewPassword = !_obscureNewPassword;
    });
  }

  void _navigateToLogin() {
    log("Navigate to Login Screen");
    context.goNamed(RouteNames.login);
  }

  Future<void> _submitForm() async {
    // Sembunyikan keyboard jika terbuka
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      // Simulasi proses API call
      await Future.delayed(const Duration(seconds: 2));

      // Tampilkan notifikasi
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Silakan cek email Anda untuk konfirmasi perubahan password.'),
            backgroundColor: AppColors.success,
          ),
        );
      }

      // Timer 5 detik sebelum kembali ke halaman Login
      Timer(const Duration(seconds: 5), () {
        if (mounted) {
          context.goNamed(RouteNames.login);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface, // Latar belakang putih
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.m * 1.5),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      HeaderPage(title: 'Forget Password'),
                      AppSpacing.vsXLarge,
                      ForgetPasswordForm(
                        formKey: _formKey,
                        emailController: _emailController,
                        newPasswordController: _newPasswordController,
                        confirmPasswordController: _confirmPasswordController,
                        onTogglePasswordVisibility: _toggleNewPasswordVisibility,
                        obscureNewPassword: _obscureNewPassword,
                      ),
                    ],
                  ),
                ),
              ),
              AppSpacing.vsLarge,
              AuthButtonActions.forgotPassword(
                onContinuePressed: _submitForm,
                onLoginPressed: _navigateToLogin,
              ),
              AppSpacing.vsMedium,
            ],
          ),
        ),
      ),
    );
  }
}

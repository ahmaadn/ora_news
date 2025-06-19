import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_spacing.dart';

import 'package:ora_news/app/constants/route_names.dart';
import 'package:ora_news/app/utils/app_notif.dart';
import 'package:ora_news/data/models/auth_models.dart';
import 'package:ora_news/data/provider/auth_provider.dart';

import 'package:ora_news/views/features/auth/widgets/auth_button_actions.dart';
import 'package:ora_news/views/features/auth/widgets/forget_password_form.dart';
import 'package:ora_news/views/features/auth/widgets/header_page.dart';
import 'package:ora_news/views/widgets/app_button.dart';
import 'package:ora_news/views/widgets/custom_button.dart';
import 'package:provider/provider.dart';

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
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final bool success = await authProvider.requestPasswordChange(
        PasswordChange(
          email: _emailController.text,
          newPassword: _confirmPasswordController.text,
        ),
      );

      if (success) {
        if (mounted) {
          AppNotif.success(
            context,
            message:
                "Permintaan perubahan password berhasil dikirim. Silakan cek email Anda untuk konfirmasi perubahan password",
          );
          context.goNamed(RouteNames.login);
        }

        // Timer 5 detik sebelum kembali ke halaman Login
      } else {
        if (mounted) {
          AppNotif.error(
            context,
            message: authProvider.errorMessage ?? 'Gagal meminta perubahan password.',
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface, // Latar belakang putih
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.m * 1.5),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          AppSpacing.vsLarge,
                          HeaderPage(title: 'Forget Password'),
                          AppSpacing.vsXLarge,
                          Consumer<AuthProvider>(
                            builder: (context, authProvider, _) {
                              return ForgetPasswordForm(
                                formKey: _formKey,
                                emailController: _emailController,
                                newPasswordController: _newPasswordController,
                                confirmPasswordController: _confirmPasswordController,
                                onTogglePasswordVisibility: _toggleNewPasswordVisibility,
                                obscureNewPassword: _obscureNewPassword,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  AppSpacing.vsLarge,
                  Consumer<AuthProvider>(
                    builder: (context, authProvider, _) {
                      return AuthButtonActions.forgotPassword(
                        onContinuePressed: _submitForm,
                        onLoginPressed: _navigateToLogin,
                      );
                    },
                  ),
                  AppSpacing.vsMedium,
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.s),
              child: GhostButton(
                onPressed: _navigateToLogin,
                text: "Back",
                icon: Icon(Icons.arrow_back),
                buttonSize: CustomButtonSize.medium,
                foregroundColor: AppColors.textPrimary,
                // buttonShape: CustomButtonShape.pill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

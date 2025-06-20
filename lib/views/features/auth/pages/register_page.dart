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
import 'package:ora_news/views/features/auth/widgets/header_page.dart';
import 'package:ora_news/views/features/auth/widgets/register_form.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;

  Future<void> _register() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_passwordController.text != _confirmPasswordController.text) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password dan Konfirmasi Password tidak cocok.')),
          );
        }
        return;
      }

      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final bool success = await authProvider.register(
        Register(
          email: _emailController.text,
          username: _usernameController.text,
          name: _fullNameController.text,
          password: _confirmPasswordController.text,
        ),
      );

      if (success) {
        if (mounted) {
          AppNotif.success(context, message: "Registrasi berhasil! Silakan login.");
          context.goNamed(RouteNames.login);
        }
      } else {
        if (mounted) {
          AppNotif.error(
            context,
            message: authProvider.errorMessage ?? 'Registrasi gagal.',
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
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
                    AppSpacing.vsLarge,
                    HeaderPage(title: "Register"),
                    AppSpacing.vsXLarge,
                    Consumer<AuthProvider>(
                      builder: (context, authProvider, child) {
                        return RegisterForm(
                          formKey: _formKey,
                          fullNameController: _fullNameController,
                          emailController: _emailController,
                          usernameController: _usernameController,
                          passwordController: _passwordController,
                          confirmPasswordController: _confirmPasswordController,
                          obscurePassword: _obscurePassword,
                          onTogglePasswordVisibility: _togglePasswordVisibility,
                        );
                      },
                    ),
                    AppSpacing.vsLarge,
                    Consumer<AuthProvider>(
                      builder: (context, authProvider, child) {
                        return AuthButtonActions.signUp(
                          onContinuePressed: _register,
                          onLoginPressed: _navigateToLogin,
                        );
                      },
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

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
import 'package:ora_news/views/features/auth/widgets/login_form.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final bool success = await authProvider.login(
        Login(username: _emailController.text, password: _passwordController.text),
      );

      if (success) {
        if (mounted) {
          AppNotif.success(context, message: 'Login berhasil');
          context.goNamed(RouteNames.home);
        }
      } else {
        if (mounted) {
          AppNotif.error(
            context,
            message: authProvider.errorMessage ?? 'Login gagal.',
            duration: const Duration(seconds: 3),
          );
        }
      }
    }
  }

  void _forgotPassword() {
    log('Navigate to Forgot Password Screen');
    context.goNamed(RouteNames.forgetPassword);
  }

  void _navigateToRegister() {
    log('Navigate to Register Screen');
    context.goNamed(RouteNames.register);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.m * 1.5),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppSpacing.vsLarge,
                      HeaderPage(title: 'Login'),
                      AppSpacing.vsXLarge,
                      Consumer<AuthProvider>(
                        builder: (context, authProvider, child) {
                          return LoginForm(
                            formKey: _formKey,
                            emailController: _emailController,
                            passwordController: _passwordController,
                            obscurePassword: _obscurePassword,
                            onTogglePasswordVisibility: _togglePasswordVisibility,
                            onForgotPassword: _forgotPassword,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              AppSpacing.vsLarge,
              Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                  return AuthButtonActions.signIn(
                    onContinuePressed: authProvider.isLoading ? () {} : _login,
                    onRegisterPressed: _navigateToRegister,
                    isLoading: authProvider.isLoading,
                    isDisabled: authProvider.isLoading,
                  );
                },
              ),
              AppSpacing.vsMedium,
            ],
          ),
        ),
      ),
    );
  }
}

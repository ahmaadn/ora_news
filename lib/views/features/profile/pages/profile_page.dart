import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_spacing.dart';
import 'package:ora_news/app/config/app_typography.dart';
import 'package:ora_news/app/constants/route_names.dart';
import 'package:ora_news/app/utils/app_notif.dart';
import 'package:ora_news/data/provider/auth_provider.dart';
import 'package:ora_news/views/widgets/app_button.dart';
import 'package:ora_news/views/widgets/custom_button.dart';
import 'package:ora_news/views/widgets/custom_form_field.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() => context.read<AuthProvider>().detailUser());
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  Future<void> _showLogoutConfirmationDialog() async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.roundedLarge),
          ),
          title: Text(
            'Konfirmasi Logout',
            textAlign: TextAlign.center,
            style: AppTypography.headline2,
          ),
          content: Text(
            'Apakah Anda yakin ingin keluar dari aplikasi ini? ',
            textAlign: TextAlign.center,
            style: AppTypography.bodyText2,
          ),
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding: const EdgeInsets.only(
            bottom: AppSpacing.m,
            left: AppSpacing.m,
            right: AppSpacing.m,
          ),
          actions: <Widget>[
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    text: "Cancel",
                    backgroundColor: AppColors.grey200,
                    foregroundColor: AppColors.textPrimary,
                  ),
                ),
                AppSpacing.hsMedium,
                Expanded(
                  child: PrimaryButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    text: "Logout",
                    backgroundColor: AppColors.error,
                    foregroundColor: AppColors.textLight,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
    if (confirmed == true) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.logout();
      context.goNamed(RouteNames.login);
    }
  }

  Future<void> _saveChanges() async {
    AuthProvider provider = Provider.of<AuthProvider>(context, listen: false);

    if (_formKey.currentState?.validate() ?? false) {
      if (_passwordController.text != _confirmPasswordController.text) {
        if (mounted) {
          AppNotif.error(context, message: 'Password dan Konfirmasi Password tidak cocok.');
          return;
        }
      }
      final success = await provider.updateUser(
        email: _emailController.text,
        username: _usernameController.text,
        name: _fullNameController.text,
        password: _passwordController.text,
      );

      if (success) {
        if (mounted) {
          AppNotif.success(context, message: "Profile Berhasil di update");
        }
      } else {
        if (mounted) {
          AppNotif.error(
            context,
            message: provider.errorMessage ?? 'Gagal update profile.',
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.errorMessage != null) {
          return Center(child: Text('Error: ${provider.errorMessage}'));
        }

        _fullNameController.text = provider.currentUser?.name ?? '';
        _usernameController.text = provider.currentUser?.username ?? '';
        _emailController.text = provider.currentUser?.email ?? '';

        return Scaffold(
          backgroundColor: AppColors.surface,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(AppSpacing.m * 1.5),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          AppSpacing.vsLarge,
                          Center(
                            child: const CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                'https://placehold.co/150x150/E9446A/FFFFFF/png?text=A',
                              ),
                            ),
                          ),

                          AppSpacing.vsMedium,
                          CustomFormField(
                            controller: _fullNameController,
                            labelText: "Full Name",
                            hintText: 'Your full name',
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            textInputAction: TextInputAction.next,
                            collapseError: false,
                            boxSize: FormFieldSize.large,
                          ),
                          AppSpacing.vsSmall,
                          CustomFormField(
                            controller: _emailController,
                            labelText: 'Email',
                            hintText: 'Your email address',
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            collapseError: false,
                            boxSize: FormFieldSize.large,
                          ),
                          AppSpacing.vsSmall,
                          CustomFormField(
                            controller: _usernameController,
                            labelText: "Username",
                            hintText: 'Your username',
                            textInputAction: TextInputAction.next,
                            collapseError: false,
                            boxSize: FormFieldSize.large,
                          ),
                          AppSpacing.vsSmall,
                          // Password Field
                          CustomFormField(
                            controller: _passwordController,
                            labelText: "Password",
                            hintText: 'Create a strong password',
                            obscureText: _obscurePassword,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: AppColors.grey500,
                              ),
                              onPressed: _togglePasswordVisibility,
                            ),
                            textInputAction: TextInputAction.next,
                            collapseError: false,
                            boxSize: FormFieldSize.large,
                          ),
                          AppSpacing.vsSmall,
                          CustomFormField(
                            controller: _confirmPasswordController,
                            labelText: "Confirmation Password",
                            hintText: 'Confirm your password',
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                            collapseError: false,
                            boxSize: FormFieldSize.large,
                          ),
                          AppSpacing.vsSmall,
                          // Logout Button
                          PrimaryButton(
                            onPressed: _saveChanges,
                            text: 'Save changes',
                            width: double.infinity,
                            buttonSize: CustomButtonSize.medium,
                            backgroundColor: AppColors.warning, // Warna kuning
                            foregroundColor:
                                AppColors.textPrimary, // Teks gelap agar kontras
                          ),
                          AppSpacing.vsSmall,
                          PrimaryButton(
                            onPressed: _showLogoutConfirmationDialog,
                            text: 'Logout',
                            width: double.infinity,
                            buttonSize: CustomButtonSize.medium,
                            backgroundColor: AppColors.error, // Warna merah untuk logout
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Bottom Navigation Bar untuk kelengkapan visual
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cab_zing/core/theme/app_colors.dart';
import 'package:cab_zing/core/widgets/app_text_field.dart';
import 'package:cab_zing/features/auth/presentation/widgets/input_field_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.usernameController,
    required this.passwordController,
    required this.obscurePassword,
    required this.onTogglePassword,
    required this.isLoading,
    required this.onLogin,
    required this.formKey,
  });

  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final bool isLoading;
  final VoidCallback onTogglePassword;
  final VoidCallback onLogin;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const Text(
              'Login',
              style: TextStyle(
                color: AppColors.textMain,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Login to your vikn account',
              style: TextStyle(color: AppColors.textSub, fontSize: 15),
            ),
            const SizedBox(height: 28),
            InputFieldCard(
              children: [
                AppTextField(
                  hint: 'Username',
                  icon: FaIcon(
                    FontAwesomeIcons.user,
                    color: AppColors.highlightAction,
                    size: 18,
                  ),
                  controller: usernameController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Username is required';
                    }
                    return null;
                  },
                ),
                const Divider(color: AppColors.border, height: 1),
                AppTextField(
                  hint: 'Password',
                  icon: FaIcon(
                    FontAwesomeIcons.key,
                    color: AppColors.highlightAction,
                    size: 18,
                  ),
                  obscureText: obscurePassword,
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                  suffix: IconButton(
                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.highlightAction,
                      size: 22,
                    ),
                    onPressed: onTogglePassword,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Forgotten Password?',
                  style: TextStyle(
                    color: AppColors.highlightAction,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: isLoading ? null : onLogin,
              style: ElevatedButton.styleFrom(minimumSize: const Size(130, 48)),
              child: isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.white,
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          'Sign in',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward,
                          size: 24,
                          color: Colors.white,
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

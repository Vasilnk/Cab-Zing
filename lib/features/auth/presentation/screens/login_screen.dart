import 'package:cab_zing/features/auth/presentation/providers/auth_provider.dart';
import 'package:cab_zing/features/auth/presentation/widgets/glow_background.dart';
import 'package:cab_zing/features/auth/presentation/widgets/language_selector.dart';
import 'package:cab_zing/features/auth/presentation/widgets/login_form.dart';
import 'package:cab_zing/features/auth/presentation/widgets/sign_up_row.dart';
import 'package:cab_zing/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool obscurePassword = true;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> handleLogin() async {
    // Validate form fields
    if (!formKey.currentState!.validate()) {
      return;
    }

    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProvider.login(username, password);

    if (!mounted) return;

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    } else if (authProvider.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authProvider.error!),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const GlowBackground(),
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      const LanguageSelector(),
                      const Spacer(),
                      Consumer<AuthProvider>(
                        builder: (context, auth, _) => LoginForm(
                          usernameController: usernameController,
                          passwordController: passwordController,
                          obscurePassword: obscurePassword,
                          isLoading: auth.isLoading,
                          formKey: formKey,
                          onLogin: handleLogin,
                          onTogglePassword: () => setState(
                            () => obscurePassword = !obscurePassword,
                          ),
                        ),
                      ),
                      const Spacer(),
                      const SignUpRow(),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

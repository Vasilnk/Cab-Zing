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

  bool obscurePassword = true;
  String? usernameError;
  String? passwordError;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> handleLogin() async {
    setState(() {
      usernameError = null;
      passwordError = null;
    });

    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty) {
      setState(() => usernameError = 'Username is required');
      return;
    }
    if (password.isEmpty) {
      setState(() => passwordError = 'Password is required');
      return;
    }

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
                          usernameError: usernameError,
                          passwordError: passwordError,
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

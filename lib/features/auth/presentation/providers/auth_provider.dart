import 'package:cab_zing/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService authService;

  bool isLoading = false;
  String? error;
  bool isLoggedIn = false;

  AuthProvider(this.authService) {
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    isLoggedIn = await authService.isLoggedIn();
    notifyListeners();
  }

  Future<bool> login(String username, String password) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      await authService.login(username, password);
      isLoggedIn = true;
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      error = e.toString().replaceAll('Exception: ', '');
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await authService.logout();
    isLoggedIn = false;
    notifyListeners();
  }
}

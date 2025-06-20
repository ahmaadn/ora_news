import 'package:flutter/material.dart';
import 'package:ora_news/app/utils/token_manager.dart';
import 'package:ora_news/data/api/auth_service.dart';
import 'package:ora_news/data/models/auth_models.dart';

class AuthProvider with ChangeNotifier {
  Token? _authToken;
  bool _isLoading = false;
  String? _errorMessage;
  bool _isLoggedIn = false;

  Token? get authResponse => _authToken;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _authToken != null;
  bool get isLoggedIn => _isLoggedIn;

  AuthProvider() {
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    _authToken = await TokenManager.getTokens();
    _isLoggedIn = _authToken != null;
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> login(Login data) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await AuthService.login(data);
    _isLoading = false;

    if (result.success) {
      _authToken = result.data;
      _isLoggedIn = _authToken != null;
      _errorMessage = null;
      notifyListeners();
      return true;
    } else {
      _errorMessage = result.message;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(Register data) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await AuthService.register(data);

    _isLoading = false;
    if (result.success) {
      _errorMessage = null;
      notifyListeners();
      return true;
    } else {
      _errorMessage = result.message;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    await TokenManager.clearTokens();
    _authToken = null;
    _isLoading = false;
    _isLoggedIn = false;
    notifyListeners();
  }

  // Fungsi untuk meminta perubahan password (Forget Password)
  Future<bool> requestPasswordChange(PasswordChange data) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await AuthService.requestPasswordChange(data);

    _isLoading = false;
    if (result.success) {
      _errorMessage = null;
      notifyListeners();
      return true;
    } else {
      _errorMessage = result.message;
      notifyListeners();
      return false;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:ora_news/app/utils/token_manager.dart';
import 'package:ora_news/data/api/auth_service.dart';
import 'package:ora_news/data/models/auth_models.dart';

class AuthProvider with ChangeNotifier {
  Token? _authToken;
  bool _isLoading = false;
  String? _errorMessage;

  Token? get authResponse => _authToken;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _authToken != null;

  AuthProvider() {
    _loadAuthResponse(); // Muat token saat inisialisasi provider
  }

  Future<void> _loadAuthResponse() async {
    _authToken = await TokenManager.getTokens();
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
    notifyListeners();
  }
}

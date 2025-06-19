import 'package:ora_news/data/models/auth_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  static const String _accessTokenKey = 'access_token';
  static const String _tokenTypeKey = 'token_type';

  /// Menyimpan token ke SharedPreferences.
  static Future<void> saveTokens(Token data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, data.accessToken);
    await prefs.setString(_tokenTypeKey, data.tokenType);
  }

  /// Mengambil token dari SharedPreferences.
  /// Mengembalikan AuthResponse jika token ada, null jika tidak.
  static Future<Token?> getTokens() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString(_accessTokenKey);
    final tokenType = prefs.getString(_tokenTypeKey);

    if (accessToken != null && tokenType != null) {
      return Token(accessToken: accessToken, tokenType: tokenType);
    }
    return null;
  }

  /// Menghapus token dari SharedPreferences (logout).
  static Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
    await prefs.remove(_tokenTypeKey);
  }

  /// Memeriksa apakah token ada.
  static Future<bool> hasTokens() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_accessTokenKey) && prefs.containsKey(_tokenTypeKey);
  }
}

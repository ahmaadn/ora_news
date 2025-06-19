import 'package:ora_news/app/utils/token_manager.dart';

class ApiConstants {
  static const String baseUrl = 'https://ora-news.vercel.app/api/v1';
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String requestPasswordChangeEndpoint = '/auth/request-password-change';

  static Future<Map<String, String>> get authHeaders async {
    var token = await TokenManager.getTokens();

    if (token == null) {
      return {'Content-Type': 'application/json'};
    }
    return {
      'Content-Type': 'application/json',
      'Authorization': '${token.tokenType} ${token.accessToken}',
    };
  }

  static Map<String, String> get headers {
    return {'Content-Type': 'application/json'};
  }
}

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ora_news/app/constants/api_constants.dart';
import 'package:ora_news/app/utils/token_manager.dart';
import 'package:ora_news/data/models/auth_models.dart';
import 'package:ora_news/data/models/message_api_model.dart';
import 'package:ora_news/data/models/user_models.dart';

class AuthService {
  static Future<MessageApiModel> login(Login data) async {
    final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.loginEndpoint}');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: data.toJson(),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final token = Token.fromJson(data);

        await TokenManager.saveTokens(token);
        return MessageApiModel<Token>.success(message: 'Login berhasil', data: token);
      } else {
        final Map<String, dynamic> errorData = json.decode(response.body);
        return MessageApiModel<Null>.error(
          message: errorData['detail']['messages'][0] ?? 'Login gagal',
        );
      }
    } catch (e) {
      return MessageApiModel<Null>.error(message: 'Terjadi kesalahan: $e');
    }
  }

  // Fungsi untuk melakukan registrasi
  static Future<MessageApiModel> register(Register data) async {
    final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.registerEndpoint}');

    try {
      final response = await http.post(
        url,
        headers: ApiConstants.headers,
        body: data.toJson(),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final User user = User.fromJson(data);

        return MessageApiModel<User>.success(message: 'Registrasi berhasil', data: user);
      } else {
        final Map<String, dynamic> errorData = json.decode(response.body);
        return MessageApiModel<Null>.error(
          message: errorData['detail']['messages'][0] ?? 'Registrasi gagal',
        );
      }
    } catch (e) {
      return MessageApiModel<Null>.error(message: 'Terjadi kesalahan: $e');
    }
  }

  static Future<MessageApiModel> requestPasswordChange(PasswordChange data) async {
    final url = Uri.parse(
      '${ApiConstants.baseUrl}${ApiConstants.requestPasswordChangeEndpoint}',
    );
    try {
      final response = await http.post(
        url,
        headers: ApiConstants.headers,
        body: data.toJson(),
      );

      if (response.statusCode == 202) {
        return MessageApiModel.success(
          message:
              'Permintaan perubahan password berhasil dikirim. Silakan cek email Anda untuk konfirmasi',
          data: null,
        );
      } else {
        final Map<String, dynamic> errorData = json.decode(response.body);
        return MessageApiModel.error(
          message: errorData['detail']['messages'][0] ?? 'Gagal meminta perubahan password',
        );
      }
    } catch (e) {
      log('AuthService: Terjadi kesalahan saat meminta perubahan password: $e');
      return MessageApiModel.error(message: 'Terjadi kesalahan: $e');
    }
  }

  static Future<MessageApiModel> getCurrentUSer() async {
    final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.userEndpoint}');

    log("URI");
    try {
      log("TEST RESPONESE");
      final response = await http.get(url, headers: await ApiConstants.authHeaders);
      log("TEST RESPONESE POST");
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        log("BERHASIL GET USER");
        final User user = User.fromJson(data);

        return MessageApiModel<User>.success(message: 'Get user berhasil', data: user);
      } else {
        final Map<String, dynamic> errorData = json.decode(response.body);
        return MessageApiModel<Null>.error(
          message: errorData['detail']['messages'][0] ?? 'Registrasi gagal',
        );
      }
    } catch (e) {
      return MessageApiModel<Null>.error(message: 'Terjadi kesalahan: $e');
    }
  }

  static Future<MessageApiModel> updateUser({
    String? email,
    String? username,
    String? name,
    String? password,
  }) async {
    final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.userEndpoint}');
    final String body = json.encode({
      if (email != null && password != '') 'email': email,
      if (username != null && password != '') 'username': username,
      if (name != null && password != '') 'name': name,
      if (password != null && password != '') 'password': password,
    });

    log("${password != null} || ${password != ''}");

    log(body);
    try {
      log("TEST RESPONESE UPADTE");
      final response = await http.put(
        url,
        headers: await ApiConstants.authHeaders,
        body: body,
      );
      log("TEST RESPONESE POST");
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        log("BERHASIL GET USER");
        final User user = User.fromJson(data);

        return MessageApiModel<User>.success(message: 'Get user berhasil', data: user);
      } else {
        log(response.body);
        return MessageApiModel<Null>.error(message: 'Registrasi gagal');
      }
    } catch (e) {
      log('Terjadi kesalahan: $e');
      return MessageApiModel<Null>.error(message: 'Terjadi kesalahan: $e');
    }
  }
}

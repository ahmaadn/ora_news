import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:ora_news/app/constants/api_constants.dart';
import 'package:ora_news/data/models/message_api_model.dart';
import 'package:ora_news/data/models/user_models.dart';

class UserNewsService {
  static Future<MessageApiModel> getAllNews({
    int page = 1,
    int perPage = 20,
    String? category,
    String? search,
    bool? latest,
  }) async {
    final queryParams = {
      'page': page,
      'per_page': perPage,
      if (category != null) 'category': category,
      if (search != null) 'search': search,
    };

    log("param : $queryParams");

    final queryString = queryParams.entries
        .map(
          (e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value.toString())}',
        )
        .join('&');

    final url = Uri.parse(
      '${ApiConstants.baseUrl}${ApiConstants.myListNewsEndpoint}?$queryString',
    );

    try {
      final response = await http.get(url, headers: await ApiConstants.authHeaders);
      log("Done Get User News :");
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return MessageApiModel.success(
          message: "Data berhasil di dapatkan",
          data: PaginationMyNews.fromJson(data),
        );
      } else {
        return MessageApiModel.error(message: "Failed to load categories");
      }
    } catch (e) {
      return MessageApiModel.error(message: 'Failed to load categories: $e');
    }
  }

  static Future<MessageApiModel> deleteNews(String newsId) async {
    final url = Uri.parse(
      '${ApiConstants.baseUrl}${ApiConstants.myListNewsEndpoint}/$newsId',
    );

    try {
      final response = await http.delete(url, headers: await ApiConstants.authHeaders);
      log("responde done : ${response.statusCode}");
      if (response.statusCode == 202) {
        log("Done Delete User News : $newsId");
        return MessageApiModel.success(message: "Data berhasil dihapus", data: null);
      } else {
        return MessageApiModel.error(message: "Failed to delete news");
      }
    } catch (e) {
      return MessageApiModel.error(message: "Terjadi kesalahan $e");
    }
  }

  static Future<MessageApiModel> createNews({
    required String title,
    required String content,
    required String categoryId,
    required String imageUrl,
  }) async {
    final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.myListNewsEndpoint}');

    try {
      final response = await http.post(
        url,
        headers: await ApiConstants.authHeaders,
        body: jsonEncode({
          'title': title,
          'content': content,
          'category_id': categoryId,
          "image_url": imageUrl,
        }),
      );
      log("responde done : ${response.statusCode}");
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        log("Done Create News :");
        return MessageApiModel.success(
          message: "Data berhasil dicreate",
          data: MyNewsArticle.fromJson(data),
        );
      } else {
        return MessageApiModel.error(message: "Failed to create news");
      }
    } catch (e) {
      log("Terjadi kesalahan $e");
      return MessageApiModel.error(message: "Terjadi kesalahan $e");
    }
  }

  static Future<MessageApiModel> updateNews(
    String newsId, {
    String? title,
    String? content,
    String? categoryId,
    String? imageUrl,
  }) async {
    final url = Uri.parse(
      '${ApiConstants.baseUrl}${ApiConstants.myListNewsEndpoint}/$newsId',
    );

    try {
      final response = await http.patch(
        url,
        headers: await ApiConstants.authHeaders,
        body: jsonEncode({
          if (title != null) 'title': title,
          if (content != null) 'content': content,
          if (categoryId != null) 'category_id': categoryId,
          if (imageUrl != null) "image_url": imageUrl,
        }),
      );
      log("responde done : ${response.statusCode}");
      if (response.statusCode == 202) {
        final Map<String, dynamic> data = json.decode(response.body);

        log("Done Update News :");
        return MessageApiModel.success(
          message: "Data berhasil DiUpdate",
          data: MyNewsArticle.fromJson(data),
        );
      } else {
        return MessageApiModel.error(message: "Failed to create news");
      }
    } catch (e) {
      log("Terjadi kesalahan $e");
      return MessageApiModel.error(message: "Terjadi kesalahan $e");
    }
  }

  static Future<MessageApiModel> uploadImage(String newsId, PlatformFile file) async {
    final url = Uri.parse(
      '${ApiConstants.baseUrl}${ApiConstants.myListNewsEndpoint}/$newsId',
    );

    try {
      var request = http.MultipartRequest('POST', url);
      if (kIsWeb) {
        // Untuk Web: Gunakan fromBytes
        request.files.add(
          http.MultipartFile.fromBytes(
            'image', // nama field
            file.bytes as List<int>,
            filename: file.name,
          ),
        );
      } else {
        // Untuk Mobile/Desktop: Gunakan fromPath
        // request.files.add(
        //   await http.MultipartFile.fromPath(
        //     'image', // nama field
        //     file.path,
        //   ),
        // );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      log("Responde done : ${response.statusCode}");
      if (response.statusCode == 202) {
        log("Upload Gambar berhasil untuk id : $newsId");
        return MessageApiModel.success(message: "Data berhasil dihapus", data: null);
      } else {
        return MessageApiModel.error(message: "Failed to delete news");
      }
    } catch (e) {
      log("Terjadi kesalahan $e");
      return MessageApiModel.error(message: "Terjadi kesalahan $e");
    }
  }
}

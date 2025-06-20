import 'dart:convert';
import 'dart:developer';

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
}

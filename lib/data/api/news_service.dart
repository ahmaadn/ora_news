import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:ora_news/app/constants/api_constants.dart';
import 'package:ora_news/data/models/message_api_model.dart';
import 'package:ora_news/data/models/news_models.dart';

class NewsService {
  static Future<MessageApiModel> getNews({
    int? page = 1,
    int? perPage = 30,
    String? author,
    String? category,
    String? search,
    bool? latest,
  }) async {
    final queryParams = {
      'page': page,
      'per_page': perPage,
      if (author != null) 'author': author,
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
      '${ApiConstants.baseUrl}${ApiConstants.newsPublicEndpoint}?$queryString',
    );

    try {
      final response = await http.get(url, headers: ApiConstants.headers);
      log("Done Get");

      if (response.statusCode == 200) {
        log("Berhasil");
        Map<String, dynamic> data = json.decode(response.body);
        log("Data berhasil di ambil");
        final newsPagination = PaginationNews.fromJson(data);
        log("Convert Pagination");
        return MessageApiModel<PaginationNews>.success(
          message: 'Data berhasil di dapatkan',
          data: newsPagination,
        );
      } else {
        log(response.body);
        return MessageApiModel.error(message: response.body);
      }
    } catch (e) {
      log("Terjadi kesalahan: $e");
      return MessageApiModel.error(message: "Terjadi kesalahan: $e");
    }
  }

  static Future<MessageApiModel> getCategories() async {
    final uri = Uri.parse(ApiConstants.baseUrl + ApiConstants.categoryEndpoint);
    try {
      final response = await http.get(uri, headers: ApiConstants.headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        return MessageApiModel.success(
          message: "Data berhasil di dapatkan",
          data: ListCategoryNews.fromJson(data),
        );
      } else {
        return MessageApiModel.error(message: "Failed to load categories");
      }
    } catch (e) {
      return MessageApiModel.error(message: 'Failed to load categories: $e');
    }
  }

  static Future<MessageApiModel> getDetailNews(String id) async {
    final uri = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.newsPublicEndpoint}$id");

    try {
      final response = await http.get(uri, headers: ApiConstants.headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        return MessageApiModel.success(
          message: "Data berhasil di dapatkan",
          data: NewsArticle.fromJson(data),
        );
      } else {
        return MessageApiModel.error(message: "Failed to load categories");
      }
    } catch (e) {
      return MessageApiModel.error(message: 'Failed to load categories: $e');
    }
  }
}

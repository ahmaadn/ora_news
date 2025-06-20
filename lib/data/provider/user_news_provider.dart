import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:ora_news/data/api/user_news_service.dart';
import 'package:ora_news/data/models/user_models.dart';

class UserNewsProvider with ChangeNotifier {
  String _userId = '';
  bool _isLoading = false;
  String? _errorMessage;

  List<MyNewsArticle> _news = [];

  List<MyNewsArticle> get news => _news;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  String get userId => _userId;

  set userId(String value) {
    _userId = value;
    notifyListeners();
  }

  Future<bool> fetchUserNews() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final results = await UserNewsService.getAllNews();
    _isLoading = false;

    if (results.success) {
      final PaginationMyNews paginate = results.data;
      _news = paginate.items;
      notifyListeners();
      log("Berhasil mendapatkan news user : ${_news.length}");
      return true;
    } else {
      _errorMessage = "Error fetching news";
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteNews(String newsId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final results = await UserNewsService.deleteNews(newsId);
    _isLoading = false;

    if (results.success) {
      notifyListeners();
      log("Berhasil menghapus news user : $newsId");
      return true;
    } else {
      _errorMessage = "Error deleting news";
      notifyListeners();
      return false;
    }
  }
}

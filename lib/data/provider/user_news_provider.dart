import 'dart:developer';
// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:ora_news/data/api/user_news_service.dart';
import 'package:ora_news/data/models/user_models.dart';

class UserNewsProvider with ChangeNotifier {
  String _userId = '';
  bool _isLoading = false;
  String? _errorMessage;

  List<MyNewsArticle> _news = [];
  int _countNews = 0;

  List<MyNewsArticle> get news => _news;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get countNews => _countNews;

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
      _countNews = paginate.count;
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

  Future<bool> createNews({
    required String title,
    required String content,
    required String categoryId,
    required String imageUrl,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final results = await UserNewsService.createNews(
      title: title,
      content: content,
      categoryId: categoryId,
      imageUrl: imageUrl,
    );

    log("Result Create News : ${results.success}");

    if (!results.success) {
      _errorMessage = "Error creating news";
      notifyListeners();
      return false;
    }

    // if (file != null) {
    //   final resultUpload = await UserNewsService.uploadImage(results.data.id, file);
    //   _isLoading = false;
    //   notifyListeners();

    //   if (resultUpload.success) {
    //     _errorMessage = null;
    //     log("Berhasil Upload Gambar : ${results.data.id}");
    //     notifyListeners();
    //     return false;
    //   } else {
    //     _errorMessage = "TIdak bisa upload gambar";
    //     notifyListeners();
    //     return false;
    //   }
    // }

    log("Berhasil Upload News : ${results.data.id}");
    return true;
  }

  Future<bool> updateNews(
    String newsId, {
    String? title,
    String? content,
    String? categoryId,
    String? imageUrl,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final results = await UserNewsService.updateNews(
      newsId,
      title: title,
      content: content,
      categoryId: categoryId,
      imageUrl: imageUrl,
    );
    _isLoading = false;

    if (results.success) {
      notifyListeners();
      log("Berhasil mengupdate news user : $newsId");
      return true;
    } else {
      _errorMessage = "Error update news";
      notifyListeners();
      return false;
    }
  }
}

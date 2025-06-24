import 'dart:developer';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:ora_news/data/api/user_news_service.dart';
import 'package:ora_news/data/models/user_models.dart';

class UserNewsProvider with ChangeNotifier {
  String _userId = '';
  bool _isLoading = false;
  bool _isLoadingUploadImage = false;
  String? _errorMessage;
  String? _errorMessageUploadImge;

  List<MyNewsArticle> _news = [];
  int _countNews = 0;

  List<MyNewsArticle> get news => _news;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get countNews => _countNews;
  bool get isLoadingUploadImage => _isLoadingUploadImage;
  String? get errorMessageUploadImge => _errorMessageUploadImge;

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
    String? imageUrl,
    File? image,
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

    if (image != null) {
      await uploadImage(newsId: results.data.id, image: image);
    }
    _isLoading = false;

    if (!results.success) {
      _errorMessage = "Error creating news";
      notifyListeners();
      return false;
    }

    log("Berhasil Upload News : ${results.data.id}");
    return true;
  }

  Future<bool> updateNews(
    String newsId, {
    String? title,
    String? content,
    String? categoryId,
    String? imageUrl,
    File? image,
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

    if (image != null) {
      await uploadImage(newsId: results.data.id, image: image);
    }
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

  Future<bool> uploadImage({required String newsId, required File image}) async {
    _isLoadingUploadImage = true;
    _errorMessageUploadImge = null;
    notifyListeners();

    final resultUpload = await UserNewsService.uploadImage(newsId: newsId, file: image);
    _isLoadingUploadImage = false;
    notifyListeners();

    if (resultUpload.success) {
      _errorMessageUploadImge = null;
      log("Berhasil Upload Gambar : $newsId");
      notifyListeners();
      return true;
    } else {
      _errorMessageUploadImge = "TIdak bisa upload gambar";
      notifyListeners();
      return false;
    }
  }
}

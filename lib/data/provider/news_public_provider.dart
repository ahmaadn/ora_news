import 'dart:developer';

import 'package:flutter/foundation.dart';

import 'package:ora_news/data/api/news_service.dart';
import 'package:ora_news/data/models/news_models.dart';

class NewsPublicProvider with ChangeNotifier {
  // State untuk daftar berita
  List<NewsArticle> _headlines = [];
  List<NewsArticle> _trending = [];
  List<NewsArticle> _highlights = [];
  List<CategoryNews> _categories = [];
  List<NewsArticle> _newsByCategory = [];
  List<NewsArticle> _newsBySearch = [];
  List<String> _recentSearches = [];

  NewsArticle? _newsArticleDetailShow;

  // State untuk kategori yang dipilih
  String? _selectedCategoryId;

  // State untuk status pemuatan
  bool _isLoading = false;
  bool _isLoadingCategoryNews = false;
  String? _errorMessage;

  // Getter untuk mengakses state dari UI
  List<NewsArticle> get headlines => _headlines;
  List<NewsArticle> get trending => _trending;
  List<NewsArticle> get highlights => _highlights;
  List<CategoryNews> get categories => _categories;
  List<NewsArticle> get newsByCategory => _newsByCategory;
  List<NewsArticle> get newsBySearch => _newsBySearch;
  List<String> get recentSearches => _recentSearches;
  String? get selectedCategoryId => _selectedCategoryId;
  bool get isLoading => _isLoading;
  bool get isLoadingCategoryNews => _isLoadingCategoryNews;
  String? get errorMessage => _errorMessage;

  NewsArticle? get newsArticleDetailShow => _newsArticleDetailShow;

  Future<bool> fetchHomeData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final results = await Future.wait([
      NewsService.getNews(perPage: 30, latest: true),
      NewsService.getCategories(),
    ]);

    log("Berhasil 2 ambil data untuk kategori dan news");
    log("${results[0].success}, ${results[1].success}");

    if (results[0].success && results[1].success) {
      log("SINIII");
      PaginationNews pagination = results[0].data;
      log("Jumlah Artikel ${pagination.items.length}");

      _headlines = pagination.items.take(5).toList();
      _highlights = pagination.items.skip(5).take(5).toList();
      _trending = pagination.items.skip(10).toList();

      _categories = results[1].data.data;
      log("Jumlah Categories ${_categories.length}");
      _errorMessage = null;
      log("Berhasil get news");
      notifyListeners();
      return true;
    } else {
      _errorMessage = "Error fetching news";
      notifyListeners();
      return false;
    }
  }

  Future<bool> fetchNewsByCategory(String? categoryId) async {
    if (_selectedCategoryId == categoryId) return false;

    _selectedCategoryId = categoryId;
    if (categoryId == null || categoryId == "All News") {
      _newsByCategory = [];
      notifyListeners();
      return false;
    }

    _isLoadingCategoryNews = true;
    _errorMessage = null;
    notifyListeners();

    final results = await NewsService.getNews(
      perPage: 30,
      latest: true,
      category: categoryId,
    );
    _isLoadingCategoryNews = false;

    if (results.success) {
      PaginationNews pagination = results.data;
      log("Jumlah Artikel ${pagination.items.length}");

      _headlines = pagination.items.take(5).toList();
      _highlights = pagination.items.skip(5).take(5).toList();
      _trending = pagination.items.skip(10).toList();

      _errorMessage = null;
      log("Berhasil get news by Category $categoryId");
      notifyListeners();
      return true;
    } else {
      _errorMessage = "Error fetching news";
      notifyListeners();
      return false;
    }
  }

  Future<bool> fetchNewsBySearch(String search) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final results = await NewsService.getNews(perPage: 20, latest: true, search: search);
    _isLoading = false;

    if (results.success) {
      PaginationNews pagination = results.data;
      log("Jumlah Artikel ${pagination.items.length}");
      _newsBySearch = pagination.items;
      _errorMessage = null;
      log("Berhasil get news by Search $search");
      notifyListeners();
      return true;
    } else {
      _errorMessage = "Error fetching news";
      notifyListeners();
      return false;
    }
  }

  Future<bool> fetchDetailNews(String id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final results = await NewsService.getDetailNews(id);
    _isLoading = false;

    if (results.success) {
      NewsArticle data = results.data;
      log("News Berhasil di peroleh : ${data.title}");
      _newsArticleDetailShow = data;
      _errorMessage = null;
      notifyListeners();
      return true;
    } else {
      _errorMessage = "Error fetching news Detail";
      notifyListeners();
      return false;
    }
  }

  void removeSearchHistory(int index) {
    _recentSearches.removeAt(index);
    notifyListeners();
  }

  void addSearchHistory(String query) {
    notifyListeners();
    if (query.trim().isEmpty) return;

    if (!_recentSearches.contains(query)) {
      _recentSearches.insert(0, query);
      notifyListeners();
    }
    notifyListeners();
  }

  Future<bool> fetchCategory() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final results = await NewsService.getCategories();

    log("Berhasil ambil kategori ");

    if (results.success) {
      _categories = results.data.data;
      log("Jumlah Categories ${_categories.length}");
      _errorMessage = null;
      notifyListeners();
      return true;
    } else {
      _errorMessage = "Error fetching news";
      notifyListeners();
      return false;
    }
  }
}

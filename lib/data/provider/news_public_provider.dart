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

  String? _selectedCategoryId = null;
  int _page = 1;
  static const int _defaultPerPage = 20;

  // State untuk status pemuatan
  bool _isLoading = false;
  bool _isLoadingCategoryNews = false;
  bool _isLoadingMore = false;
  String? _errorMessage;

  // Getters untuk mengakses state dari UI
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
  bool get isLoadingMore => _isLoadingMore;

  // Pagination
  int get page => _page;
  int get perPage => _defaultPerPage;

  NewsArticle? get newsArticleDetailShow => _newsArticleDetailShow;

  void _setLoading(bool value, {String? message}) {
    _isLoading = value;
    _errorMessage = message;
    notifyListeners();
  }

  void _setLoadingCategoryNews(bool value, {String? message}) {
    _isLoadingCategoryNews = value;
    _errorMessage = message;
    notifyListeners();
  }

  void _setLoadingMore(bool value, {String? message}) {
    _isLoadingMore = value;
    _errorMessage = message;
    notifyListeners();
  }

  Future<bool> fetchHomeData() async {
    _setLoading(true);

    try {
      final results = await Future.wait([
        NewsService.getNews(perPage: 30, latest: true),
        NewsService.getCategories(),
      ]);

      if (results[0].success && results[1].success) {
        final PaginationNews pagination = results[0].data;
        log("Berhasil get news");
        log("Jumlah Artikel ${pagination.items.length}");
        log("Jumlah Categories ${_categories.length}");

        _headlines = pagination.items.take(5).toList();
        _highlights = pagination.items.skip(5).take(5).toList();
        _trending = pagination.items.skip(10).toList();
        _categories = results[1].data.data;

        _selectedCategoryId = null;
        _page = 1;

        _setLoading(false, message: null);
        return true;
      } else {
        _setLoading(false, message: "Error fetching home data: ${results[0].message}");
        return false;
      }
    } catch (e) {
      _setLoading(false, message: "An unexpected error occurred: $e");
      return false;
    }
  }

  Future<bool> loadMoreNews({String? search}) async {
    _setLoadingMore(true);

    final results = await NewsService.getNews(
      perPage: _defaultPerPage,
      latest: true,
      category: _selectedCategoryId,
      page: _page + 1,
      search: search,
    );

    if (results.success) {
      _page += 1;
      PaginationNews pagination = results.data;

      if (search != null) {
        _newsBySearch.addAll(pagination.items);
      } else {
        if (pagination.items.isNotEmpty) {
          _trending.addAll(pagination.items);
        }
        if (_selectedCategoryId != null) {
          _newsByCategory.addAll(pagination.items);
        }
      }

      log(
        "Berhasil get news Page: $_page Perpage: $_defaultPerPage, Category: $_selectedCategoryId, Search $search",
      );
      _setLoadingMore(false);
      return true;
    } else {
      _setLoadingMore(false, message: "Error loading more news: ${results.message}");
      return false;
    }
  }

  Future<bool> fetchNewsByCategory(String categoryId, {bool forceRefresh = false}) async {
    if (_selectedCategoryId == categoryId && !forceRefresh) {
      log("Category $categoryId already selected. No refetch needed.");
      return false;
    }

    _selectedCategoryId = categoryId;
    _page = 1;

    if (categoryId == "all") {
      _newsByCategory = [];
      notifyListeners();
      return false;
    }

    _setLoading(true);

    final results = await NewsService.getNews(
      perPage: _defaultPerPage,
      latest: true,
      category: categoryId,
    );

    if (results.success) {
      PaginationNews pagination = results.data;
      log(
        "Berhasil get news by Category $categoryId, Jumlah Artikel ${pagination.items.length}",
      );

      // Update _newsByCategory list for the selected category
      _newsByCategory = pagination.items;

      _headlines = pagination.items.take(5).toList();
      _highlights = pagination.items.skip(5).take(5).toList();
      _trending = pagination.items.skip(10).toList();

      _setLoading(false, message: null);
      return true;
    } else {
      _setLoading(false, message: 'Error fetching news');
      return false;
    }
  }

  Future<bool> fetchNewsBySearch(String search) async {
    _setLoading(true);
    _page = 1;

    final results = await NewsService.getNews(perPage: 20, latest: true, search: search);

    if (results.success) {
      PaginationNews pagination = results.data;
      _newsBySearch = pagination.items;

      log("Berhasil get news by Search $search, Jumlah Artikel ${pagination.items.length}");

      _setLoading(false, message: null);
      return true;
    } else {
      _setLoading(false, message: '"Error fetching news by search: ${results.message}"');
      return false;
    }
  }

  Future<bool> fetchDetailNews(String id) async {
    _setLoading(true);

    final results = await NewsService.getDetailNews(id);

    if (results.success) {
      NewsArticle data = results.data;
      log("News Berhasil di peroleh : ${data.title}");
      _newsArticleDetailShow = data;
      _setLoading(false, message: null);
      return true;
    } else {
      _setLoading(false, message: "Error fetching news Detail");
      return false;
    }
  }

  void removeSearchHistory(int index) {
    _recentSearches.removeAt(index);
    notifyListeners();
  }

  void addSearchHistory(String query) {
    final trimmedQuery = query.trim();
    if (trimmedQuery.isEmpty) return;

    if (!_recentSearches.contains(trimmedQuery)) {
      _recentSearches.insert(0, trimmedQuery);
      // Limit search history to a certain number, e.g., 10
      if (_recentSearches.length > 10) {
        _recentSearches.removeLast();
      }
      notifyListeners();
    }
    // If it already exists, move it to the top
    else {
      _recentSearches.remove(trimmedQuery);
      _recentSearches.insert(0, trimmedQuery);
      notifyListeners();
    }
  }

  Future<bool> fetchCategory() async {
    _setLoadingCategoryNews(true);

    final results = await NewsService.getCategories();

    log("Berhasil ambil kategori ");

    if (results.success) {
      _categories = results.data.data;
      log("Jumlah Categories ${_categories.length}");
      _setLoadingCategoryNews(false);
      return true;
    } else {
      _setLoadingCategoryNews(false);
      return false;
    }
  }

  void resetState() {
    _headlines = [];
    _trending = [];
    _highlights = [];
    _categories = [];
    _newsByCategory = [];
    _newsBySearch = [];
    _recentSearches.clear();
    _newsArticleDetailShow = null;
    _selectedCategoryId = null;
    _page = 1;
    _isLoadingMore = false;
    _isLoading = false;
    _isLoadingCategoryNews = false;
    _errorMessage = null;
    notifyListeners();
  }
}

import 'package:ora_news/data/models/user_models.dart';

class PaginationNews {
  final int count;
  final List<NewsArticle> items;
  final int currPage;
  final int totalPage;
  final String? nextPage;
  final String? previousPage;

  PaginationNews({
    required this.count,
    required this.items,
    required this.currPage,
    required this.totalPage,
    this.nextPage,
    this.previousPage,
  });

  PaginationNews copyWith({
    int? count,
    List<NewsArticle>? items,
    int? currPage,
    int? totalPage,
    String? nextPage,
    dynamic previousPage,
  }) => PaginationNews(
    count: count ?? this.count,
    items: items ?? this.items,
    currPage: currPage ?? this.currPage,
    totalPage: totalPage ?? this.totalPage,
    nextPage: nextPage ?? this.nextPage,
    previousPage: previousPage ?? this.previousPage,
  );

  factory PaginationNews.fromJson(Map<String, dynamic> json) => PaginationNews(
    count: json["count"],
    items: List<NewsArticle>.from(json['items'].map((x) => NewsArticle.fromJson(x))),
    currPage: json["curr_page"],
    totalPage: json["total_page"],
    nextPage: json["next_page"],
    previousPage: json["previous_page"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "items": List<NewsArticle>.from(items.map((x) => x.toJson())),
    "curr_page": currPage,
    "total_page": totalPage,
    "next_page": nextPage,
    "previous_page": previousPage,
  };
}

class NewsArticle {
  final DateTime createAt;
  final DateTime updateAt;
  final String id;
  final String title;
  final String content;
  String? imageUrl;
  final DateTime publishedAt;
  final CategoryNews category;
  final UserPublic user;

  NewsArticle({
    required this.createAt,
    required this.updateAt,
    required this.id,
    required this.title,
    required this.content,
    this.imageUrl,
    required this.publishedAt,
    required this.category,
    required this.user,
  });

  NewsArticle copyWith({
    DateTime? createAt,
    DateTime? updateAt,
    String? id,
    String? title,
    String? content,
    String? imageUrl,
    DateTime? publishedAt,
    CategoryNews? category,
    UserPublic? user,
  }) => NewsArticle(
    createAt: createAt ?? this.createAt,
    updateAt: updateAt ?? this.updateAt,
    id: id ?? this.id,
    title: title ?? this.title,
    content: content ?? this.content,
    imageUrl: imageUrl ?? this.imageUrl,
    publishedAt: publishedAt ?? this.publishedAt,
    category: category ?? this.category,
    user: user ?? this.user,
  );

  factory NewsArticle.fromJson(Map<String, dynamic> json) => NewsArticle(
    createAt: DateTime.parse(json["create_at"]),
    updateAt: DateTime.parse(json["update_at"]),
    id: json["id"],
    title: json["title"],
    content: json["content"],
    imageUrl: json["image_url"],
    publishedAt: DateTime.parse(json["published_at"]),
    category: CategoryNews.fromJson(json["category"]),
    user: UserPublic.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "create_at": createAt.toIso8601String(),
    "update_at": updateAt.toIso8601String(),
    "id": id,
    "title": title,
    "content": content,
    "image_url": imageUrl,
    "published_at": publishedAt.toIso8601String(),
    "category": category.toJson(),
    "user": user.toJson(),
  };
}

class ListCategoryNews {
  final int totalCount;
  final List<CategoryNews> data;

  ListCategoryNews({required this.totalCount, required this.data});

  ListCategoryNews copyWith({int? totalCount, List<CategoryNews>? data}) =>
      ListCategoryNews(totalCount: totalCount ?? this.totalCount, data: data ?? this.data);

  factory ListCategoryNews.fromJson(Map<String, dynamic> json) => ListCategoryNews(
    totalCount: json["total_count"],
    data: List<CategoryNews>.from(json["data"].map((x) => CategoryNews.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total_count": totalCount,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CategoryNews {
  final String id;
  final String name;

  CategoryNews({required this.id, required this.name});

  CategoryNews copyWith({String? id, String? name}) =>
      CategoryNews(id: id ?? this.id, name: name ?? this.name);

  factory CategoryNews.fromJson(Map<String, dynamic> json) =>
      CategoryNews(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

import 'package:ora_news/data/models/news_models.dart';

class User {
  final DateTime createAt;
  final DateTime updateAt;
  final String id;
  final String username;
  final String email;
  final String name;
  final dynamic avatarUrl;
  final bool isActive;
  final bool isVerified;

  User({
    required this.createAt,
    required this.updateAt,
    required this.id,
    required this.username,
    required this.email,
    required this.name,
    required this.avatarUrl,
    required this.isActive,
    required this.isVerified,
  });

  User copyWith({
    DateTime? createAt,
    DateTime? updateAt,
    String? id,
    String? username,
    String? email,
    String? name,
    dynamic avatarUrl,
    bool? isActive,
    bool? isVerified,
  }) => User(
    createAt: createAt ?? this.createAt,
    updateAt: updateAt ?? this.updateAt,
    id: id ?? this.id,
    username: username ?? this.username,
    email: email ?? this.email,
    name: name ?? this.name,
    avatarUrl: avatarUrl ?? this.avatarUrl,
    isActive: isActive ?? this.isActive,
    isVerified: isVerified ?? this.isVerified,
  );

  factory User.fromJson(Map<String, dynamic> json) => User(
    createAt: DateTime.parse(json["create_at"]),
    updateAt: DateTime.parse(json["update_at"]),
    id: json["id"],
    username: json["username"],
    email: json["email"],
    name: json["name"],
    avatarUrl: json["avatar_url"],
    isActive: json["is_active"],
    isVerified: json["is_verified"],
  );

  Map<String, dynamic> toJson() => {
    "create_at": createAt.toIso8601String(),
    "update_at": updateAt.toIso8601String(),
    "id": id,
    "username": username,
    "email": email,
    "name": name,
    "avatar_url": avatarUrl,
    "is_active": isActive,
    "is_verified": isVerified,
  };
}

class UserPublic {
  final String username;
  final String name;

  UserPublic({required this.username, required this.name});

  UserPublic copyWith({String? username, String? name}) =>
      UserPublic(username: username ?? this.username, name: name ?? this.name);

  factory UserPublic.fromJson(Map<String, dynamic> json) =>
      UserPublic(username: json["username"], name: json["name"]);

  Map<String, dynamic> toJson() => {"username": username, "name": name};
}

class PaginationMyNews {
  final int count;
  final List<MyNewsArticle> items;
  final int currPage;
  final int totalPage;
  final String? nextPage;
  final String? previousPage;

  PaginationMyNews({
    required this.count,
    required this.items,
    required this.currPage,
    required this.totalPage,
    this.nextPage,
    this.previousPage,
  });

  PaginationMyNews copyWith({
    int? count,
    List<MyNewsArticle>? items,
    int? currPage,
    int? totalPage,
    String? nextPage,
    String? previousPage,
  }) => PaginationMyNews(
    count: count ?? this.count,
    items: items ?? this.items,
    currPage: currPage ?? this.currPage,
    totalPage: totalPage ?? this.totalPage,
    nextPage: nextPage ?? this.nextPage,
    previousPage: previousPage ?? this.previousPage,
  );

  factory PaginationMyNews.fromJson(Map<String, dynamic> json) => PaginationMyNews(
    count: json["count"],
    items: List<MyNewsArticle>.from(json["items"].map((x) => MyNewsArticle.fromJson(x))),
    currPage: json["curr_page"],
    totalPage: json["total_page"],
    nextPage: json["next_page"],
    previousPage: json["previous_page"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "curr_page": currPage,
    "total_page": totalPage,
    "next_page": nextPage,
    "previous_page": previousPage,
  };
}

class MyNewsArticle {
  final String id;
  final String title;
  final String content;
  final String? imageUrl;
  final CategoryNews category;
  final DateTime publishedAt;

  MyNewsArticle({
    required this.id,
    required this.title,
    required this.content,
    this.imageUrl,
    required this.category,
    required this.publishedAt,
  });

  MyNewsArticle copyWith({
    String? id,
    String? title,
    String? content,
    String? imageUrl,
    CategoryNews? category,
    DateTime? publishedAt,
  }) => MyNewsArticle(
    id: id ?? this.id,
    title: title ?? this.title,
    content: content ?? this.content,
    imageUrl: imageUrl ?? this.imageUrl,
    category: category ?? this.category,
    publishedAt: publishedAt ?? this.publishedAt,
  );

  factory MyNewsArticle.fromJson(Map<String, dynamic> json) => MyNewsArticle(
    id: json["id"],
    title: json["title"],
    content: json["content"],
    imageUrl: json["image_url"],
    category: CategoryNews.fromJson(json["category"]),
    publishedAt: DateTime.parse(json["published_at"] + 'Z'),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "content": content,
    "image_url": imageUrl,
    "category": category.toJson(),
    "published_at": publishedAt.toIso8601String(),
  };
}

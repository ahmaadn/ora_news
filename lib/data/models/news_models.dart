import 'package:ora_news/data/models/user_models.dart';

class NewsArticle {
  final DateTime createAt;
  final DateTime updateAt;
  final String id;
  final String title;
  final String content;
  final String imageUrl;
  final DateTime publishedAt;
  final CategoryNews category;
  final UserPublic user;

  NewsArticle({
    required this.createAt,
    required this.updateAt,
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
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

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

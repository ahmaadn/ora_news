import 'dart:convert';

// TOKEN
class Token {
  final String accessToken;
  final String tokenType;

  Token({required this.accessToken, required this.tokenType});

  Token copyWith({String? accessToken, String? tokenType}) => Token(
    accessToken: accessToken ?? this.accessToken,
    tokenType: tokenType ?? this.tokenType,
  );

  factory Token.fromJson(Map<String, dynamic> json) =>
      Token(accessToken: json["access_token"], tokenType: json["token_type"]);

  Map<String, dynamic> toJson() => {"access_token": accessToken, "token_type": tokenType};
}

// LOGIN MODEL
class Login {
  final String username;
  final String password;

  Login({required this.username, required this.password});

  Login copyWith({String? username, String? password}) =>
      Login(username: username ?? this.username, password: password ?? this.password);

  factory Login.fromJson(Map<String, dynamic> json) =>
      Login(username: json["username"], password: json["password"]);

  Map<String, dynamic> toJson() => {"username": username, "password": password};
}

// REGISTER MODEL
class Register {
  final String email;
  final String username;
  final String name;
  final String password;

  Register({
    required this.email,
    required this.username,
    required this.name,
    required this.password,
  });

  Register copyWith({String? email, String? username, String? name, String? password}) =>
      Register(
        email: email ?? this.email,
        username: username ?? this.username,
        name: name ?? this.name,
        password: password ?? this.password,
      );

  factory Register.fromJson(Map<String, dynamic> json) => Register(
    email: json["email"],
    username: json["username"],
    name: json["name"],
    password: json["password"],
  );

  String toJson() => jsonEncode({
    "email": email,
    "username": username,
    "name": name,
    "password": password,
  });
}

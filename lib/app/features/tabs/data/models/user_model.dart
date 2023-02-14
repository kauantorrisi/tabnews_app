import 'dart:convert';

import 'package:tabnews_app/app/features/tabs/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.username,
    required super.email,
    required super.notifications,
    required super.features,
    required super.tabcoins,
    required super.tabcash,
    required super.createdAt,
    required super.updatedAt,
  });

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        notifications: json["notifications"],
        features: List<String>.from(json["features"].map((x) => x)),
        tabcoins: json["tabcoins"],
        tabcash: json["tabcash"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "notifications": notifications,
        "features": List<dynamic>.from(features.map((x) => x)),
        "tabcoins": tabcoins,
        "tabcash": tabcash,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

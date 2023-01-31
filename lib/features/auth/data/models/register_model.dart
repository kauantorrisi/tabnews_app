import 'dart:convert';

import 'package:tabnews_app/features/auth/domain/entities/register_entity.dart';

class RegisterModel extends RegisterEntity {
  const RegisterModel({
    required super.id,
    required super.username,
    required super.features,
    required super.tabcoins,
    required super.tabcash,
    required super.createdAt,
    required super.updatedAt,
  });

  factory RegisterModel.fromRawJson(String str) =>
      RegisterModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        id: json["id"],
        username: json["username"],
        features: List<String>.from(json["features"].map((x) => x)),
        tabcoins: json["tabcoins"],
        tabcash: json["tabcash"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "features": List<dynamic>.from(features.map((x) => x)),
        "tabcoins": tabcoins,
        "tabcash": tabcash,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };

  @override
  List<Object?> get props => [
        id,
        username,
        features,
        tabcoins,
        tabcash,
        createdAt,
        updatedAt,
      ];
}

import 'dart:convert';

import 'package:tabnews_app/app/features/auth/domain/entities/recovery_password_entity.dart';

class RecoveryPasswordModel extends RecoveryPasswordEntity {
  const RecoveryPasswordModel({
    required super.used,
    required super.expiresAt,
    required super.createdAt,
    required super.updatedAt,
  });

  factory RecoveryPasswordModel.fromRawJson(String str) =>
      RecoveryPasswordModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecoveryPasswordModel.fromJson(Map<String, dynamic> json) =>
      RecoveryPasswordModel(
        used: json["used"],
        expiresAt: DateTime.parse(json["expires_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "used": used,
        "expires_at": expiresAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };

  @override
  List<Object?> get props => [
        used,
        expiresAt,
        createdAt,
        updatedAt,
      ];
}

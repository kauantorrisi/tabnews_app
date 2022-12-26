import 'dart:convert';

import 'package:tabnews_app/features/tabnews/domain/entities/tab_entity.dart';

class TabModel extends TabEntity {
  const TabModel({
    required super.id,
    required super.ownerId,
    required super.parentId,
    required super.slug,
    required super.title,
    required super.body,
    required super.status,
    required super.sourceUrl,
    required super.createdAt,
    required super.updatedAt,
    required super.publishedAt,
    required super.deletedAt,
    required super.tabcoins,
    required super.ownerUsername,
    required super.childrenDeepCount,
    required super.children,
  });

  factory TabModel.fromRawJson(String str) =>
      TabModel.fromJson(jsonDecode(str));

  String toRawJson() => jsonEncode(toJson());

  factory TabModel.fromJson(Map<String, dynamic> json) => TabModel(
        id: json["id"],
        ownerId: json["owner_id"],
        parentId: json["parent_id"],
        slug: json["slug"],
        title: json["title"],
        body: json["body"],
        status: json["status"],
        sourceUrl: json["source_url"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        publishedAt: DateTime.parse(json["published_at"]),
        deletedAt: json["deleted_at"],
        tabcoins: json["tabcoins"],
        ownerUsername: json["owner_username"],
        childrenDeepCount: json["children_deep_count"],
        children: json["children"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "owner_id": ownerId,
        "parent_id": parentId,
        "slug": slug,
        "title": title,
        "body": body,
        "status": status,
        "source_url": sourceUrl,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "published_at": publishedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "tabcoins": tabcoins,
        "owner_username": ownerUsername,
        "children_deep_count": childrenDeepCount,
        "children": children,
      };

  @override
  List<Object?> get props => [
        id,
        ownerId,
        parentId,
        slug,
        title,
        status,
        sourceUrl,
        createdAt,
        updatedAt,
        publishedAt,
        deletedAt,
        tabcoins,
        ownerUsername,
        childrenDeepCount,
        children,
      ];
}

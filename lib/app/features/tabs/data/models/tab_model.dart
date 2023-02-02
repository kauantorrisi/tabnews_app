import 'dart:convert';

import 'package:tabnews_app/app/features/tabs/domain/entities/tab_entity.dart';

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
    required super.children,
    required super.childrenDeepCount,
  });

  factory TabModel.fromJson(String str) => TabModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TabModel.fromMap(Map<String, dynamic> json) => TabModel(
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
        ownerUsername: json["owner_username"],
        tabcoins: json["tabcoins"],
        children: json["children"],
        childrenDeepCount: json["children_deep_count"],
      );

  Map<String, dynamic> toMap() => {
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
        "owner_username": ownerUsername,
        "tabcoins": tabcoins,
        "children": children,
        "children_deep_count": childrenDeepCount,
      };

  @override
  List<Object?> get props => [
        id,
        ownerId,
        parentId,
        slug,
        title,
        body,
        status,
        sourceUrl,
        createdAt,
        updatedAt,
        publishedAt,
        deletedAt,
        tabcoins,
        ownerUsername,
        children,
        childrenDeepCount,
      ];
}

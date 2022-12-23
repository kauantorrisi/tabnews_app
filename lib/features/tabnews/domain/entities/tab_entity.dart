import 'package:equatable/equatable.dart';

class TabEntity extends Equatable {
  const TabEntity({
    required this.id,
    required this.ownerId,
    required this.parentId,
    required this.slug,
    required this.title,
    required this.body,
    required this.status,
    required this.sourceUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.deletedAt,
    required this.tabcoins,
    required this.ownerUsername,
    required this.childrenDeepCount,
  });

  final String id;
  final String ownerId;
  final dynamic parentId;
  final String slug;
  final String title;
  final String? body;
  final String status;
  final dynamic sourceUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime publishedAt;
  final dynamic deletedAt;
  final int tabcoins;
  final String ownerUsername;
  final int childrenDeepCount;

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
        childrenDeepCount,
      ];
}

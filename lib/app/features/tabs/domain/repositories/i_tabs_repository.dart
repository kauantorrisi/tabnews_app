import 'package:dartz/dartz.dart';

import 'package:tabnews_app/app/core/errors/app_failures.dart';
import 'package:tabnews_app/app/features/tabs/domain/entities/tab_entity.dart';

abstract class ITabsRepository {
  Future<Either<Failure, List<TabEntity>>> getAllTabs(
      int page, int perPage, String strategy);

  Future<Either<Failure, TabEntity>> getTab(String ownerUsername, String slug);

  Future<Either<Failure, List<TabEntity>>> getTabComments(
      String ownerUsername, String slug);

  Future<Either<Failure, TabEntity>> postTab(
      String title, String body, String status);

  // TODO UP-VOTE AND DOWN-VOTE GET REQUEST
}

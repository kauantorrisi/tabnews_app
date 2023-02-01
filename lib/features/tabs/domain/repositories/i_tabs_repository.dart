import 'package:dartz/dartz.dart';

import 'package:tabnews_app/core/errors/app_failures.dart';
import 'package:tabnews_app/features/tabs/domain/entities/tab_entity.dart';
import 'package:tabnews_app/features/tabs/domain/entities/user_entity.dart';

abstract class ITabsRepository {
  Future<Either<Failure, List<TabEntity>>> getAllTabs(
      int page, int perPage, String strategy);

  Future<Either<Failure, TabEntity>> getTab(String ownerUsername, String slug);

  Future<Either<Failure, List<TabEntity>>> getTabComments(
      String ownerUsername, String slug);

  Future<Either<Failure, UserEntity>> getUser(String token);

  // TODO UP-VOTE AND DOWN-VOTE GET REQUEST
}

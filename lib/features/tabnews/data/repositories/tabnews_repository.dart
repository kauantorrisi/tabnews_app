import 'package:dartz/dartz.dart';

import 'package:tabnews_app/core/errors/app_exceptions.dart';
import 'package:tabnews_app/core/errors/app_failures.dart';
import 'package:tabnews_app/features/tabnews/data/datasources/tabnews_datasource.dart';
import 'package:tabnews_app/features/tabnews/domain/entities/tab_entity.dart';
import 'package:tabnews_app/features/tabnews/domain/repositories/i_tabnews_repository.dart';

class TabNewsRepository implements ITabNewsRepository {
  final ITabNewsDatasource datasource;

  TabNewsRepository(this.datasource);

  @override
  Future<Either<Failure, List<TabEntity>>> getAllTabs(
      int page, int perPage, String strategy) async {
    try {
      final response = await datasource.getAllTabs(page, perPage, strategy);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      rethrow;
    }
  }
}

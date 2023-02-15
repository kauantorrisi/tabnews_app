import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:tabnews_app/app/core/errors/app_exceptions.dart';
import 'package:tabnews_app/app/core/errors/app_failures.dart';
import 'package:tabnews_app/app/features/tabs/data/datasources/tabs_datasource.dart';
import 'package:tabnews_app/app/features/tabs/domain/entities/tab_entity.dart';
import 'package:tabnews_app/app/features/tabs/domain/entities/user_entity.dart';
import 'package:tabnews_app/app/features/tabs/domain/repositories/i_tabs_repository.dart';

class TabsRepository implements ITabsRepository {
  final ITabsDatasource datasource;

  TabsRepository(this.datasource);

  @override
  Future<Either<Failure, List<TabEntity>>> getAllTabs(
      int page, int perPage, String strategy) async {
    try {
      final response = await datasource.getAllTabs(page, perPage, strategy);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      if (e is DioError) {
        return Left(ServerFailure(e.response?.data["message"]));
      }
      rethrow;
    }
  }

  @override
  Future<Either<Failure, TabEntity>> getTab(
      String ownerUsername, String slug) async {
    try {
      final response = await datasource.getTab(ownerUsername, slug);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      if (e is DioError) {
        return Left(ServerFailure(e.response?.data["message"]));
      }
      rethrow;
    }
  }

  @override
  Future<Either<Failure, List<TabEntity>>> getTabComments(
      String ownerUsername, String slug) async {
    try {
      final response = await datasource.getTabComments(ownerUsername, slug);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUser(String token) async {
    try {
      final response = await datasource.getUser(token);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      if (e is DioError) {
        return Left(ServerFailure(e.response?.data['message']));
      }
      rethrow;
    }
  }

  @override
  Future<Either<Failure, TabEntity>> postTab(String title, String body,
      String status, String sourceUrl, String slug, String token) async {
    try {
      final response =
          await datasource.postTab(title, body, status, sourceUrl, slug, token);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      rethrow;
    }
  }
}

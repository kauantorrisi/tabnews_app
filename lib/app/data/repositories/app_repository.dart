import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:tabnews_app/app/core/errors/app_exceptions.dart';
import 'package:tabnews_app/app/core/errors/app_failures.dart';
import 'package:tabnews_app/app/data/datasources/app_datasource.dart';
import 'package:tabnews_app/app/domain/entities/user_entity.dart';
import 'package:tabnews_app/app/domain/repositories/i_app_repository.dart';

class AppRepository implements IAppRepository {
  final IAppDatasource datasource;

  AppRepository(this.datasource);

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
}

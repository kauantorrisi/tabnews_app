import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:tabnews_app/core/errors/app_exceptions.dart';
import 'package:tabnews_app/core/errors/app_failures.dart';
import 'package:tabnews_app/features/auth/data/datasources/auth_datasource.dart';
import 'package:tabnews_app/features/auth/domain/entities/login_entity.dart';
import 'package:tabnews_app/features/auth/domain/entities/recovery_password_entity.dart';
import 'package:tabnews_app/features/auth/domain/entities/user_entity.dart';
import 'package:tabnews_app/features/auth/domain/repositories/i_auth_repository.dart';

class AuthRepository implements IAuthRepository {
  final IAuthDatasource datasource;

  AuthRepository(this.datasource);

  @override
  Future<Either<Failure, LoginEntity>> login(
      String email, String password) async {
    try {
      final response = await datasource.login(email, password);
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
  Future<Either<Failure, void>> register(
      String username, String email, String password) async {
    try {
      final response = await datasource.register(username, email, password);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, RecoveryPasswordEntity>> recoveryPassword(
      String emailOrUsername) async {
    try {
      final response = await datasource.recoveryPassword(emailOrUsername);
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
}

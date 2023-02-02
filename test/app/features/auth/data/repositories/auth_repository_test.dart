import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:tabnews_app/app/core/errors/app_exceptions.dart';
import 'package:tabnews_app/app/core/errors/app_failures.dart';
import 'package:tabnews_app/app/features/auth/data/datasources/auth_datasource.dart';
import 'package:tabnews_app/app/features/auth/data/repositories/auth_repository.dart';

import '../../mocks/t_login_model.dart';
import '../../mocks/t_recovery_password_model.dart';
import '../../mocks/t_user_model.dart';

class MockAuthDatasource extends Mock implements IAuthDatasource {}

void main() {
  late MockAuthDatasource mockAuthDatasource;
  late AuthRepository repository;

  setUp(() {
    mockAuthDatasource = MockAuthDatasource();
    repository = AuthRepository(mockAuthDatasource);
  });

  group('Login', () {
    test(
        'should return a LoginModel when the call of the datasource is successful',
        () async {
      when(() => mockAuthDatasource.login(any(), any()))
          .thenAnswer((_) async => tLoginModel);

      final result = await repository.login('', '');

      expect(result, equals(Right(tLoginModel)));
    });

    test(
        'should return a ServerFailure when the call of the datasource is unsuccessful',
        () async {
      when(() => mockAuthDatasource.login(any(), any()))
          .thenThrow(ServerException());

      final result = await repository.login('', '');

      expect(result, Left(ServerFailure()));
    });
  });

  group('RecoveryPassword', () {
    test(
        'should return a RecoveryPasswordModel when the call of the datasource is successful',
        () async {
      when(() => mockAuthDatasource.recoveryPassword(any()))
          .thenAnswer((_) async => tRecoveryPasswordModel);

      final result = await repository.recoveryPassword('');

      expect(result, Right(tRecoveryPasswordModel));
    });

    test(
        'should return a ServerFailure when the call of the datasource is unsuccessful',
        () async {
      when(() => mockAuthDatasource.recoveryPassword(any()))
          .thenThrow(ServerException());

      final result = await repository.recoveryPassword('');

      expect(result, Left(ServerFailure()));
    });
  });

  group('getUser', () {
    test('should return a UserModel when the call of datasource is successful',
        () async {
      when(() => mockAuthDatasource.getUser(any()))
          .thenAnswer((_) async => tUserModel);

      final result = await repository.getUser('');

      expect(result, Right(tUserModel));
    });

    test(
        'should return a ServerFailure when the call of datasource is unsuccessful',
        () async {
      when(() => mockAuthDatasource.getUser(any()))
          .thenThrow(ServerException());

      final result = await repository.getUser('');

      expect(result, Left(ServerFailure()));
    });
  });
}

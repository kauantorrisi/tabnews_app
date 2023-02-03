import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:tabnews_app/app/core/errors/app_exceptions.dart';
import 'package:tabnews_app/app/core/errors/app_failures.dart';
import 'package:tabnews_app/app/data/datasources/app_datasource.dart';
import 'package:tabnews_app/app/data/repositories/app_repository.dart';

import '../../features/auth/mocks/t_user_model.dart';

class MockAppDatasource extends Mock implements IAppDatasource {}

void main() {
  late MockAppDatasource mockAppDatasource;
  late AppRepository repository;

  setUp(() {
    mockAppDatasource = MockAppDatasource();
    repository = AppRepository(mockAppDatasource);
  });

  group('getUser', () {
    test('should return a UserModel when the call of datasource is successful',
        () async {
      when(() => mockAppDatasource.getUser(any()))
          .thenAnswer((_) async => tUserModel);

      final result = await repository.getUser('');

      expect(result, Right(tUserModel));
    });

    test(
        'should return a ServerFailure when the call of datasource is unsuccessful',
        () async {
      when(() => mockAppDatasource.getUser(any())).thenThrow(ServerException());

      final result = await repository.getUser('');

      expect(result, Left(ServerFailure()));
    });
  });
}

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';

import 'package:tabnews_app/app_module.dart';
import 'package:tabnews_app/core/errors/app_exceptions.dart';
import 'package:tabnews_app/core/errors/app_failures.dart';
import 'package:tabnews_app/features/tabnews/data/datasources/tabnews_datasource.dart';
import 'package:tabnews_app/features/tabnews/data/repositories/tabnews_repository.dart';

import '../../mocks/t_list_tab_models.dart';
import '../../mocks/t_tab_model.dart';

class MockTabNewsDatasource extends Mock implements ITabNewsDatasource {}

void main() {
  late ITabNewsDatasource mockTabNewsDatasource;
  late TabNewsRepository repository;

  setUp(() {
    initModule(AppModule());
    mockTabNewsDatasource = MockTabNewsDatasource();
    repository = TabNewsRepository(mockTabNewsDatasource);
  });

  group('getAllTabs', () {
    test(
        'should return a List<TabModel> when the call of datasource is successful',
        () async {
      when(() => mockTabNewsDatasource.getAllTabs(any(), any(), any()))
          .thenAnswer((_) async => tListTabModels);

      final result = await repository.getAllTabs(1, 1, 'relevant');

      expect(result, Right(tListTabModels));
    });

    test(
        'should return a ServerFailure when the call of datasource is unsuccessful',
        () async {
      when(() => mockTabNewsDatasource.getAllTabs(any(), any(), any()))
          .thenThrow(ServerException());

      final result = await repository.getAllTabs(1, 1, 'relevant');

      expect(result, Left(ServerFailure()));
    });
  });

  group('getTab', () {
    test('should return a TabModel when the call of datasource is successful',
        () async {
      when(() => mockTabNewsDatasource.getTab(any(), any()))
          .thenAnswer((_) async => tTabModel);

      final result = await repository.getTab('ownerUsername', 'slug');

      expect(result, Right(tTabModel));
    });

    test(
        'should return a ServerFailure when the call of datasource is unsuccessful',
        () async {
      when(() => mockTabNewsDatasource.getTab(any(), any()))
          .thenThrow(ServerException());

      final result = await repository.getTab('ownerUsername', 'slug');

      expect(result, Left(ServerFailure()));
    });
  });

  group('getTabComments', () {
    test(
        'should return a List<TabModel> when the call of datasource is successful',
        () async {
      when(() => mockTabNewsDatasource.getTabComments(any(), any()))
          .thenAnswer((_) async => tListTabModels);

      final result = await repository.getTabComments('ownerUsername', 'slug');

      expect(result, Right(tListTabModels));
    });

    test(
        'should return a ServerFailure when the call of datasource is unsuccessful',
        () async {
      when(() => mockTabNewsDatasource.getTabComments(any(), any()))
          .thenThrow(ServerException());

      final result = await repository.getTabComments('ownerUsername', 'slug');

      expect(result, Left(ServerFailure()));
    });
  });
}

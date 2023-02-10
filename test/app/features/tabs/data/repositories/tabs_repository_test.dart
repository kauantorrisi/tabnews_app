import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';

import 'package:tabnews_app/app/app_module.dart';
import 'package:tabnews_app/app/core/errors/app_exceptions.dart';
import 'package:tabnews_app/app/core/errors/app_failures.dart';
import 'package:tabnews_app/app/features/tabs/data/datasources/tabs_datasource.dart';
import 'package:tabnews_app/app/features/tabs/data/repositories/tabs_repository.dart';

import '../../mocks/t_list_tab_models.dart';
import '../../mocks/t_tab_model.dart';

class MockTabsDatasource extends Mock implements ITabsDatasource {}

void main() {
  late ITabsDatasource mockTabsDatasource;
  late TabsRepository repository;

  setUp(() {
    initModule(AppModule());
    mockTabsDatasource = MockTabsDatasource();
    repository = TabsRepository(mockTabsDatasource);
  });

  group('getAllTabs', () {
    test(
        'should return a List<TabModel> when the call of datasource is successful',
        () async {
      when(() => mockTabsDatasource.getAllTabs(any(), any(), any()))
          .thenAnswer((_) async => tListTabModels);

      final result = await repository.getAllTabs(1, 1, 'relevant');

      expect(result, Right(tListTabModels));
    });

    test(
        'should return a ServerFailure when the call of datasource is unsuccessful',
        () async {
      when(() => mockTabsDatasource.getAllTabs(any(), any(), any()))
          .thenThrow(ServerException());

      final result = await repository.getAllTabs(1, 1, 'relevant');

      expect(result, Left(ServerFailure()));
    });
  });

  group('getTab', () {
    test('should return a TabModel when the call of datasource is successful',
        () async {
      when(() => mockTabsDatasource.getTab(any(), any()))
          .thenAnswer((_) async => tTabModel);

      final result = await repository.getTab('ownerUsername', 'slug');

      expect(result, Right(tTabModel));
    });

    test(
        'should return a ServerFailure when the call of datasource is unsuccessful',
        () async {
      when(() => mockTabsDatasource.getTab(any(), any()))
          .thenThrow(ServerException());

      final result = await repository.getTab('ownerUsername', 'slug');

      expect(result, Left(ServerFailure()));
    });
  });

  group('getTabComments', () {
    test(
        'should return a List<TabModel> when the call of datasource is successful',
        () async {
      when(() => mockTabsDatasource.getTabComments(any(), any()))
          .thenAnswer((_) async => tListTabModels);

      final result = await repository.getTabComments('ownerUsername', 'slug');

      expect(result, Right(tListTabModels));
    });

    test(
        'should return a ServerFailure when the call of datasource is unsuccessful',
        () async {
      when(() => mockTabsDatasource.getTabComments(any(), any()))
          .thenThrow(ServerException());

      final result = await repository.getTabComments('ownerUsername', 'slug');

      expect(result, Left(ServerFailure()));
    });
  });

  group('postTab', () {
    test('should return a TabModel when the call of datasource is successful',
        () async {
      when(() => mockTabsDatasource.postTab(any(), any(), any(), any()))
          .thenAnswer((invocation) async => tTabModel);

      final result = await repository.postTab('title', 'body', 'status', '');

      expect(result, Right(tTabModel));
    });

    test(
        'should return a ServerFailure when the call of datasource is unsuccessful',
        () async {
      when(() => mockTabsDatasource.postTab(any(), any(), any(), any()))
          .thenThrow(ServerException());

      final result = await repository.postTab('title', 'body', 'status', '');

      expect(result, Left(ServerFailure()));
    });
  });
}

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:tabnews_app/features/tabnews/domain/repositories/i_tabnews_repository.dart';
import 'package:tabnews_app/features/tabnews/domain/usecases/get_all_tabs_usecase.dart';

import '../../../../mocks/t_list_tab_entities.dart';

class MockTabNewsRepository extends Mock implements ITabNewsRepository {}

void main() {
  late ITabNewsRepository mockTabNewsRepository;
  late GetAllTabsUsecase usecase;

  setUp(() {
    mockTabNewsRepository = MockTabNewsRepository();
    usecase = GetAllTabsUsecase(mockTabNewsRepository);
  });

  test(
      'should return a List<TabEntity> when the call of repository is successful',
      () async {
    when(() => mockTabNewsRepository.getAllTabs(any(), any(), any()))
        .thenAnswer((_) async => Right(tListTabEntities));

    final result = await usecase(
        const GetAllTabsParams(page: 1, perPage: 1, strategy: 'strategy'));

    expect(result, isA<Right>());
    expect(result, equals(Right(tListTabEntities)));
    verify(() => mockTabNewsRepository.getAllTabs(any(), any(), any()))
        .called(1);
    verifyNoMoreInteractions(mockTabNewsRepository);
  });
}

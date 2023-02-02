import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:tabnews_app/app/features/tabs/domain/repositories/i_tabs_repository.dart';
import 'package:tabnews_app/app/features/tabs/domain/usecases/get_all_tabs_usecase.dart';

import '../../mocks/t_list_tab_entities.dart';

class MockTabsRepository extends Mock implements ITabsRepository {}

void main() {
  late ITabsRepository mockTabsRepository;
  late GetAllTabsUsecase usecase;

  setUp(() {
    mockTabsRepository = MockTabsRepository();
    usecase = GetAllTabsUsecase(mockTabsRepository);
  });

  test(
      'should return a List<TabEntity> when the call of repository is successful',
      () async {
    when(() => mockTabsRepository.getAllTabs(any(), any(), any()))
        .thenAnswer((_) async => Right(tListTabEntities));

    final result = await usecase(
        const GetAllTabsParams(page: 1, perPage: 1, strategy: 'strategy'));

    expect(result, isA<Right>());
    expect(result, equals(Right(tListTabEntities)));
    verify(() => mockTabsRepository.getAllTabs(any(), any(), any())).called(1);
    verifyNoMoreInteractions(mockTabsRepository);
  });
}

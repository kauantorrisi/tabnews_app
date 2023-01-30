import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';
import 'package:tabnews_app/app_module.dart';

import 'package:tabnews_app/features/tabs/domain/repositories/i_tabnews_repository.dart';
import 'package:tabnews_app/features/tabs/domain/usecases/get_tab_comments_usecase.dart';

import '../../mocks/t_list_tab_entities.dart';

class MockITabsRepository extends Mock implements ITabsRepository {}

void main() {
  late MockITabsRepository mockITabsRepository;
  late GetTabCommentsUsecase usecase;

  setUp(() {
    initModule(AppModule());
    mockITabsRepository = MockITabsRepository();
    usecase = GetTabCommentsUsecase(mockITabsRepository);
  });

  test(
      'should return a List<TabEntity> when the call of repository is successful',
      () async {
    when(() => mockITabsRepository.getTabComments(any(), any()))
        .thenAnswer((_) async => Right(tListTabEntities));

    final result = await usecase(const GetTabCommentsParams(
        ownerUsername: 'ownerUsername', slug: 'slug'));

    expect(result, isA<Right>());
    expect(result, Right(tListTabEntities));
    verify(() => mockITabsRepository.getTabComments(any(), any())).called(1);
    verifyNoMoreInteractions(mockITabsRepository);
  });
}

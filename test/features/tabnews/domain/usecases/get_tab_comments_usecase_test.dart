import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';
import 'package:tabnews_app/app_module.dart';

import 'package:tabnews_app/features/tabnews/domain/repositories/i_tabnews_repository.dart';
import 'package:tabnews_app/features/tabnews/domain/usecases/get_tab_comments_usecase.dart';

import '../../mocks/t_list_tab_entities.dart';

class MockITabNewsRepository extends Mock implements ITabNewsRepository {}

void main() {
  late MockITabNewsRepository mockITabNewsRepository;
  late GetTabCommentsUsecase usecase;

  setUp(() {
    initModule(AppModule());
    mockITabNewsRepository = MockITabNewsRepository();
    usecase = GetTabCommentsUsecase(mockITabNewsRepository);
  });

  test(
      'should return a List<TabEntity> when the call of repository is successful',
      () async {
    when(() => mockITabNewsRepository.getTabComments(any(), any()))
        .thenAnswer((_) async => Right(tListTabEntities));

    final result = await usecase(const GetTabCommentsParams(
        ownerUsername: 'ownerUsername', slug: 'slug'));

    expect(result, isA<Right>());
    expect(result, Right(tListTabEntities));
    verify(() => mockITabNewsRepository.getTabComments(any(), any())).called(1);
    verifyNoMoreInteractions(mockITabNewsRepository);
  });
}

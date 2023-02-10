import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:tabnews_app/app/features/tabs/domain/repositories/i_tabs_repository.dart';
import 'package:tabnews_app/app/features/tabs/domain/usecases/post_tab_usecase.dart';

import '../../mocks/t_tab_entity.dart';

class MockTabsRepository extends Mock implements ITabsRepository {}

void main() {
  late MockTabsRepository mockTabsRepository;
  late PostTabUsecase usecase;

  setUp(() {
    mockTabsRepository = MockTabsRepository();
    usecase = PostTabUsecase(mockTabsRepository);
  });

  test('should return a TabEntity when the call of repository is successful',
      () async {
    when(() => mockTabsRepository.postTab(any(), any(), any(), any()))
        .thenAnswer((invocation) async => Right(tTabEntity));

    final result =
        await usecase(const PostTabParams('title', 'body', 'status', ''));

    expect(result, isA<Right>());
    expect(result, equals(Right(tTabEntity)));
    verify(() => mockTabsRepository.postTab(any(), any(), any(), any()))
        .called(1);
    verifyNoMoreInteractions(mockTabsRepository);
  });
}

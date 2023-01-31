import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';

import 'package:tabnews_app/app_module.dart';
import 'package:tabnews_app/features/tabs/domain/repositories/i_tabnews_repository.dart';
import 'package:tabnews_app/features/tabs/domain/usecases/get_tab_usecase.dart';

import '../../mocks/t_tab_entity.dart';

class MockITabsRepository extends Mock implements ITabsRepository {}

void main() {
  late MockITabsRepository mockITabsRepository;
  late GetTabUsecase usecase;

  setUp(() {
    initModule(AppModule());
    mockITabsRepository = MockITabsRepository();
    usecase = GetTabUsecase(mockITabsRepository);
  });

  test('should return a TabEntity when the call of repository is successful',
      () async {
    when(() => mockITabsRepository.getTab(any(), any()))
        .thenAnswer((_) async => Right(tTabEntity));

    final result = await usecase(
        const GetTabParams(ownerUsername: 'ownerUsername', slug: 'slug'));

    expect(result, isA<Right>());
    expect(result, equals(Right(tTabEntity)));
    verify(() => mockITabsRepository.getTab(any(), any()));
    verifyNoMoreInteractions(mockITabsRepository);
  });
}

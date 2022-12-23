import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';
import 'package:tabnews_app/app_module.dart';
import 'package:tabnews_app/features/tabnews/domain/repositories/i_tabnews_repository.dart';
import 'package:tabnews_app/features/tabnews/domain/usecases/get_tab_usecase.dart';

import '../../../../mocks/t_tab_entity.dart';

class MockITabNewsRepository extends Mock implements ITabNewsRepository {}

void main() {
  late MockITabNewsRepository mockITabNewsRepository;
  late GetTabUsecase usecase;

  setUp(() {
    initModule(AppModule());
    mockITabNewsRepository = MockITabNewsRepository();
    usecase = GetTabUsecase(mockITabNewsRepository);
  });

  test('should return a TabEntity when the call of repository is successful',
      () async {
    when(() => mockITabNewsRepository.getTab(any(), any()))
        .thenAnswer((_) async => Right(tTabEntity));

    final result = await usecase(
        const GetTabParams(ownerUsername: 'ownerUsername', slug: 'slug'));

    expect(result, isA<Right>());
    expect(result, equals(Right(tTabEntity)));
    verify(() => mockITabNewsRepository.getTab(any(), any()));
    verifyNoMoreInteractions(mockITabNewsRepository);
  });
}

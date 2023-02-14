import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:tabnews_app/app/features/tabs/data/repositories/tabs_repository.dart';
import 'package:tabnews_app/app/features/tabs/domain/usecases/get_user_usecase.dart';

import '../../mocks/t_user_entity.dart';

class MockTabsRepository extends Mock implements TabsRepository {}

void main() {
  late MockTabsRepository mockTabsRepository;
  late GetUserUsecase usecase;

  setUp(() {
    mockTabsRepository = MockTabsRepository();
    usecase = GetUserUsecase(mockTabsRepository);
  });

  test(
      'should return a UserEntity when the call of the repository is successful',
      () async {
    when(() => mockTabsRepository.getUser(any()))
        .thenAnswer((_) async => Right(tUserEntity));

    final result = await usecase(const UserParams(''));

    expect(result, isA<Right>());
    expect(result, equals(Right(tUserEntity)));
    verify(() => mockTabsRepository.getUser(any())).called(1);
    verifyNoMoreInteractions(mockTabsRepository);
  });
}

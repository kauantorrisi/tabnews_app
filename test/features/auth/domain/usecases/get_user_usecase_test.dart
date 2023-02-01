import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tabnews_app/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:tabnews_app/features/auth/domain/usecases/get_user_usecase.dart';

import '../../mocks/t_user_entity.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late GetUserUsecase usecase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = GetUserUsecase(mockAuthRepository);
  });

  test(
      'should return a UserEntity when the call of the repository is successful',
      () async {
    when(() => mockAuthRepository.getUser(any()))
        .thenAnswer((_) async => Right(tUserEntity));

    final result = await usecase(const UserParams(''));

    expect(result, isA<Right>());
    expect(result, equals(Right(tUserEntity)));
    verify(() => mockAuthRepository.getUser(any())).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });
}

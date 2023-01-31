import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:tabnews_app/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:tabnews_app/features/auth/domain/usecases/login_usecase.dart';

import '../../mocks/t_login_entity.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late LoginUsecase usecase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = LoginUsecase(mockAuthRepository);
  });

  test('should return a LoginEntity when the call of repository is succesful',
      () async {
    when(() => mockAuthRepository.login(any(), any()))
        .thenAnswer((_) async => Right(tLoginEntity));

    final result = await usecase(const LoginParams(email: '', password: ''));

    expect(result, isA<Right>());
    expect(result, equals(Right(tLoginEntity)));
    verify(() => mockAuthRepository.login(any(), any())).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });
}

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:tabnews_app/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:tabnews_app/features/auth/domain/usecases/register_usecase.dart';

import '../../mocks/t_register_entity.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late RegisterUsecase usecase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = RegisterUsecase(mockAuthRepository);
  });

  test(
      'should return a RegisterEntity when the call of repository is successful',
      () async {
    when(() => mockAuthRepository.register(any(), any(), any()))
        .thenAnswer((_) async => Right(tRegisterEntity));

    final result = await usecase(const RegisterParams('', '', ''));

    expect(result, isA<Right>());
    expect(result, equals(Right(tRegisterEntity)));
    verify(() => mockAuthRepository.register(any(), any(), any())).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });
}

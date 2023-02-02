import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tabnews_app/app/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:tabnews_app/app/features/auth/domain/usecases/recovery_password_usecase.dart';

import '../../mocks/t_recovery_password_entity.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late RecoveryPasswordUsecase usecase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = RecoveryPasswordUsecase(mockAuthRepository);
  });

  test(
      'should return a RecoveryPasswordEntity when the call of repository is successful',
      () async {
    when(() => mockAuthRepository.recoveryPassword(any()))
        .thenAnswer((_) async => Right(tRecoveryPasswordEntity));

    final result = await usecase(const RecoveryPasswordParams(''));

    expect(result, isA<Right>());
    expect(result, equals(Right(tRecoveryPasswordEntity)));
    verify(() => mockAuthRepository.recoveryPassword(any())).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });
}

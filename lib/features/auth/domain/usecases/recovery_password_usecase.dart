import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tabnews_app/core/errors/app_failures.dart';
import 'package:tabnews_app/core/usecases/usecase.dart';
import 'package:tabnews_app/features/auth/domain/entities/recovery_password_entity.dart';
import 'package:tabnews_app/features/auth/domain/repositories/i_auth_repository.dart';

class RecoveryPasswordUsecase
    implements Usecase<RecoveryPasswordEntity, RecoveryPasswordParams> {
  final IAuthRepository repository;

  RecoveryPasswordUsecase(this.repository);

  @override
  Future<Either<Failure, RecoveryPasswordEntity>> call(
      RecoveryPasswordParams params) async {
    return await repository.recoveryPassword(params.emailOrUsername);
  }
}

class RecoveryPasswordParams extends Equatable {
  final String emailOrUsername;

  const RecoveryPasswordParams(this.emailOrUsername);

  @override
  List<Object?> get props => [emailOrUsername];
}

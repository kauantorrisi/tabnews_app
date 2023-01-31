import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tabnews_app/core/errors/app_failures.dart';
import 'package:tabnews_app/core/usecases/usecase.dart';
import 'package:tabnews_app/features/auth/domain/entities/register_entity.dart';
import 'package:tabnews_app/features/auth/domain/repositories/i_auth_repository.dart';

class RegisterUsecase implements Usecase<RegisterEntity, RegisterParams> {
  final IAuthRepository repository;

  RegisterUsecase(this.repository);

  @override
  Future<Either<Failure, RegisterEntity>> call(RegisterParams params) async {
    return await repository.register(
        params.username, params.email, params.password);
  }
}

class RegisterParams extends Equatable {
  final String username;
  final String email;
  final String password;

  const RegisterParams(this.username, this.email, this.password);

  @override
  List<Object?> get props => [username, email, password];
}

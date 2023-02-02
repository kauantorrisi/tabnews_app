import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:tabnews_app/app/core/errors/app_failures.dart';
import 'package:tabnews_app/app/core/usecases/usecase.dart';
import 'package:tabnews_app/app/features/auth/domain/entities/login_entity.dart';
import 'package:tabnews_app/app/features/auth/domain/repositories/i_auth_repository.dart';

class LoginUsecase implements Usecase<LoginEntity, LoginParams> {
  final IAuthRepository repository;

  LoginUsecase(this.repository);

  @override
  Future<Either<Failure, LoginEntity>> call(LoginParams params) async {
    return await repository.login(params.email, params.password);
  }
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:tabnews_app/core/errors/app_failures.dart';
import 'package:tabnews_app/core/usecases/usecase.dart';
import 'package:tabnews_app/features/auth/domain/entities/user_entity.dart';
import 'package:tabnews_app/features/auth/domain/repositories/i_auth_repository.dart';

class GetUserUsecase implements Usecase<UserEntity, UserParams> {
  final IAuthRepository repository;

  GetUserUsecase(this.repository);
  @override
  Future<Either<Failure, UserEntity>> call(UserParams params) async {
    return await repository.getUser(params.token);
  }
}

class UserParams extends Equatable {
  final String token;

  const UserParams(this.token);

  @override
  List<Object?> get props => [token];
}

import 'package:dartz/dartz.dart';

import 'package:tabnews_app/core/errors/app_failures.dart';
import 'package:tabnews_app/features/auth/domain/entities/login_entity.dart';
import 'package:tabnews_app/features/auth/domain/entities/recovery_password_entity.dart';
import 'package:tabnews_app/features/auth/domain/entities/register_entity.dart';

abstract class IAuthRepository {
  Future<Either<Failure, LoginEntity>> login(String email, String password);

  Future<Either<Failure, RegisterEntity>> register(
    String username,
    String email,
    String password,
  );

  Future<Either<Failure, RecoveryPasswordEntity>> recoveryPassword(
      String emailOrUsername);
}

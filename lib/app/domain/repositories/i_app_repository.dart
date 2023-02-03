import 'package:dartz/dartz.dart';

import 'package:tabnews_app/app/core/errors/app_failures.dart';
import 'package:tabnews_app/app/domain/entities/user_entity.dart';

abstract class IAppRepository {
  Future<Either<Failure, UserEntity>> getUser(String token);
}

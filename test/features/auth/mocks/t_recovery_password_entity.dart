import 'package:tabnews_app/features/auth/domain/entities/recovery_password_entity.dart';

final RecoveryPasswordEntity tRecoveryPasswordEntity = RecoveryPasswordEntity(
  used: false,
  expiresAt: DateTime.now(),
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

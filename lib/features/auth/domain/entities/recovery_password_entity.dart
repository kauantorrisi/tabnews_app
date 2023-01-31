import 'package:equatable/equatable.dart';

class RecoveryPasswordEntity extends Equatable {
  const RecoveryPasswordEntity({
    required this.used,
    required this.expiresAt,
    required this.createdAt,
    required this.updatedAt,
  });

  final bool used;
  final DateTime expiresAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  List<Object?> get props => [
        used,
        expiresAt,
        createdAt,
        updatedAt,
      ];
}

import 'package:equatable/equatable.dart';

class RegisterEntity extends Equatable {
  const RegisterEntity({
    required this.id,
    required this.username,
    required this.features,
    required this.tabcoins,
    required this.tabcash,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String username;
  final List<String> features;
  final int tabcoins;
  final int tabcash;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  List<Object?> get props => [
        id,
        username,
        features,
        tabcoins,
        tabcash,
        createdAt,
        updatedAt,
      ];
}

class UserEntity {
  UserEntity({
    required this.id,
    required this.username,
    required this.email,
    required this.notifications,
    required this.features,
    required this.tabcoins,
    required this.tabcash,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  String username;
  final String email;
  final bool notifications;
  final List<String> features;
  int tabcoins;
  int tabcash;
  final DateTime createdAt;
  final DateTime updatedAt;
}

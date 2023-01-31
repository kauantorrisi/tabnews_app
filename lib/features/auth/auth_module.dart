import 'package:flutter_modular/flutter_modular.dart';
import 'package:tabnews_app/features/auth/presenter/pages/auth_page.dart';

class AuthModule extends Module {
  List<Bind> get services => [];

  List<Bind> get cubits => [];

  @override
  List<Bind> get binds => services + cubits;

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute,
            child: (context, args) => const AuthPage()),
      ];
}

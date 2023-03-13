import 'package:flutter_modular/flutter_modular.dart';

import 'package:tabnews_app/app/features/auth/auth_module.dart';
import 'package:tabnews_app/app/features/tabs/tabs_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/auth-module/', module: AuthModule()),
        ModuleRoute('/tabs-module/', module: TabsModule()),
      ];
}

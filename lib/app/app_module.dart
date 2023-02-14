import 'package:flutter_modular/flutter_modular.dart';
import 'package:tabnews_app/app/data/datasources/app_datasource.dart';
import 'package:tabnews_app/app/data/repositories/app_repository.dart';
import 'package:tabnews_app/app/domain/usecases/get_user_usecase.dart';

import 'package:tabnews_app/app/features/auth/auth_module.dart';
import 'package:tabnews_app/app/features/auth/presenter/pages/splash_page.dart';
import 'package:tabnews_app/app/features/tabs/tabs_module.dart';

class AppModule extends Module {
  List<Bind> get services => [
        Bind.lazySingleton((i) => AppDatasource()),
        Bind.lazySingleton((i) => AppRepository(i())),
        Bind.lazySingleton((i) => GetUserUsecase(i())),
      ];

  @override
  List<Bind> get binds => services;

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute,
            child: (context, args) => const SplashPage()),
        ModuleRoute('/auth-module/', module: AuthModule()),
        ModuleRoute('/tabs-module/', module: TabsModule()),
      ];
}

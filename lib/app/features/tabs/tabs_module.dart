import 'package:flutter_modular/flutter_modular.dart';

import 'package:tabnews_app/app/features/tabs/data/datasources/tabs_datasource.dart';
import 'package:tabnews_app/app/features/tabs/data/repositories/tabs_repository.dart';
import 'package:tabnews_app/app/features/tabs/domain/usecases/get_all_tabs_usecase.dart';
import 'package:tabnews_app/app/features/tabs/domain/usecases/get_tab_comments_usecase.dart';
import 'package:tabnews_app/app/features/tabs/domain/usecases/get_tab_usecase.dart';
import 'package:tabnews_app/app/features/tabs/presenter/cubit/tabs_cubit.dart';
import 'package:tabnews_app/app/features/tabs/presenter/pages/pressed_tab_page.dart';
import 'package:tabnews_app/app/features/tabs/presenter/pages/tabs_page.dart';

class TabsModule extends Module {
  static List<Bind> services = [
    Bind.lazySingleton((i) => TabsDatasource()),
    Bind.lazySingleton((i) => TabsRepository(i())),
    Bind.lazySingleton((i) => GetAllTabsUsecase(i())),
    Bind.lazySingleton((i) => GetTabUsecase(i())),
    Bind.lazySingleton((i) => GetTabCommentsUsecase(i())),
  ];

  static List<Bind> cubits = [
    Bind.lazySingleton((i) => TabsCubit(i(), i(), i())),
  ];

  @override
  List<Bind> get binds => services + cubits;

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => TabsPage(
            email: args.data['email'],
            username: args.data['username'],
            notifications: args.data['notifications'],
            tabcoins: args.data['tabcoins'],
            tabcash: args.data['tabcash'],
          ),
        ),
        ChildRoute(
          '/pressed-tab-page',
          child: (context, args) => PressedTabPage(
            cubit: args.data['cubit'],
            tabCoins: args.data['tabCoins'],
            tabCash: args.data['tabCash'],
          ),
        ),
      ];
}

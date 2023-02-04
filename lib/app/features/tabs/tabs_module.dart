import 'package:flutter_modular/flutter_modular.dart';

import 'package:tabnews_app/app/domain/usecases/get_user_usecase.dart';
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
    Bind.lazySingleton((i) => GetUserUsecase(i()))
  ];

  static List<Bind> cubits = [
    Bind.lazySingleton((i) => TabsCubit(i(), i(), i(), i())),
  ];

  @override
  List<Bind> get binds => services + cubits;

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => TabsPage(
            token: args.data['token'],
            username: args.data['username'],
            tabCoins: args.data['tabcoins'],
            tabCash: args.data['tabcash'],
            isGuest: args.data['isGuest'],
          ),
        ),
        ChildRoute(
          '/pressed-tab-page',
          child: (context, args) => PressedTabPage(
            cubit: args.data['cubit'],
            tabCoins: args.data['tabCoins'],
            tabCash: args.data['tabCash'],
            token: args.data['token'],
            isGuest: args.data['isGuest'],
          ),
        ),
      ];
}

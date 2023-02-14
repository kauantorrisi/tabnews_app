import 'package:flutter_modular/flutter_modular.dart';

import 'package:tabnews_app/app/features/tabs/domain/usecases/get_user_usecase.dart';
import 'package:tabnews_app/app/features/tabs/data/datasources/tabs_datasource.dart';
import 'package:tabnews_app/app/features/tabs/data/repositories/tabs_repository.dart';
import 'package:tabnews_app/app/features/tabs/domain/usecases/get_all_tabs_usecase.dart';
import 'package:tabnews_app/app/features/tabs/domain/usecases/get_tab_comments_usecase.dart';
import 'package:tabnews_app/app/features/tabs/domain/usecases/get_tab_usecase.dart';
import 'package:tabnews_app/app/features/tabs/domain/usecases/post_tab_usecase.dart';
import 'package:tabnews_app/app/features/tabs/presenter/cubits/postTabPage/post_tab_cubit.dart';
import 'package:tabnews_app/app/features/tabs/presenter/cubits/tabsPage/tabs_cubit.dart';
import 'package:tabnews_app/app/features/tabs/presenter/pages/post_tab_page.dart';
import 'package:tabnews_app/app/features/tabs/presenter/pages/pressed_tab_page.dart';
import 'package:tabnews_app/app/features/tabs/presenter/pages/tabs_page.dart';

class TabsModule extends Module {
  static List<Bind> services = [
    Bind.lazySingleton((i) => TabsDatasource()),
    Bind.lazySingleton((i) => TabsRepository(i())),
    Bind.lazySingleton((i) => GetAllTabsUsecase(i())),
    Bind.lazySingleton((i) => GetTabUsecase(i())),
    Bind.lazySingleton((i) => GetTabCommentsUsecase(i())),
    Bind.lazySingleton((i) => GetUserUsecase(i())),
    Bind.lazySingleton((i) => PostTabUsecase(i())),
  ];

  static List<Bind> cubits = [
    Bind.lazySingleton((i) => TabsCubit(i(), i(), i(), i())),
    Bind.lazySingleton((i) => PostTabCubit(i()))
  ];

  @override
  List<Bind> get binds => services + cubits;

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => TabsPage(
            token: args.data['token'],
            isGuest: args.data['isGuest'],
          ),
        ),
        ChildRoute(
          '/pressed-tab-page',
          child: (context, args) => PressedTabPage(
            cubit: args.data['cubit'],
            token: args.data['token'],
            isGuest: args.data['isGuest'],
          ),
        ),
        ChildRoute(
          '/post-tab-page',
          child: (context, args) => PostTabPage(
            tabCash: args.data["tabCash"],
            tabCoins: args.data["tabCoins"],
            token: args.data["token"],
            username: args.data["username"],
          ),
        )
      ];
}

import 'package:flutter_modular/flutter_modular.dart';

import 'package:tabnews_app/features/tabnews/data/datasources/tabnews_datasource.dart';
import 'package:tabnews_app/features/tabnews/data/repositories/tabnews_repository.dart';
import 'package:tabnews_app/features/tabnews/domain/usecases/get_all_tabs_usecase.dart';
import 'package:tabnews_app/features/tabnews/domain/usecases/get_tab_comments_usecase.dart';
import 'package:tabnews_app/features/tabnews/domain/usecases/get_tab_usecase.dart';
import 'package:tabnews_app/features/tabnews/presenter/cubit/tabnews_cubit.dart';
import 'package:tabnews_app/features/tabnews/presenter/pages/pressed_tab_page.dart';
import 'package:tabnews_app/features/tabnews/presenter/pages/tabs_page.dart';

class AppModule extends Module {
  static List<Bind> services = [
    Bind.lazySingleton((i) => TabNewsDatasource()),
    Bind.lazySingleton((i) => TabNewsRepository(i())),
    Bind.lazySingleton((i) => GetAllTabsUsecase(i())),
    Bind.lazySingleton((i) => GetTabUsecase(i())),
    Bind.lazySingleton((i) => GetTabCommentsUsecase(i())),
  ];

  static List<Bind> cubits = [
    Bind.lazySingleton((i) => TabnewsCubit(i(), i(), i())),
  ];

  @override
  List<Bind> get binds => services + cubits;

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => const TabsPage(),
        ),
        ChildRoute(
          '/pressed-tab-page',
          child: (context, args) => PressedTabPage(cubit: args.data),
        ),
      ];
}

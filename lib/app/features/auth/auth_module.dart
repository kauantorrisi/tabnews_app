import 'package:flutter_modular/flutter_modular.dart';

import 'package:tabnews_app/app/features/tabs/domain/usecases/get_user_usecase.dart';
import 'package:tabnews_app/app/features/auth/data/datasources/auth_datasource.dart';
import 'package:tabnews_app/app/features/auth/data/repositories/auth_repository.dart';
import 'package:tabnews_app/app/features/auth/domain/usecases/login_usecase.dart';
import 'package:tabnews_app/app/features/auth/domain/usecases/recovery_password_usecase.dart';
import 'package:tabnews_app/app/features/auth/domain/usecases/register_usecase.dart';
import 'package:tabnews_app/app/features/auth/presenter/cubit/auth_cubit.dart';
import 'package:tabnews_app/app/features/auth/presenter/pages/login_page.dart';
import 'package:tabnews_app/app/features/auth/presenter/pages/recovery_password_page.dart';
import 'package:tabnews_app/app/features/auth/presenter/pages/register_page.dart';
import 'package:tabnews_app/app/features/auth/presenter/pages/splash_page.dart';

class AuthModule extends Module {
  List<Bind> get services => [
        Bind.lazySingleton((i) => AuthDatasource()),
        Bind.lazySingleton((i) => AuthRepository(i())),
        Bind.lazySingleton((i) => LoginUsecase(i())),
        Bind.lazySingleton((i) => RegisterUsecase(i())),
        Bind.lazySingleton((i) => RecoveryPasswordUsecase(i())),
      ];

  List<Bind> get cubits => [
        Bind.lazySingleton((i) => AuthCubit(i(), i(), i())),
      ];

  @override
  List<Bind> get binds => services + cubits;

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute,
            child: (context, args) => const SplashPage()),
        ChildRoute('/login-page', child: (context, args) => LoginPage()),
        ChildRoute('/register-page', child: (context, args) => RegisterPage()),
        ChildRoute('/recovery-password-page',
            child: (context, args) => RecoveryPasswordPage(
                  cubit: args.data,
                )),
      ];
}

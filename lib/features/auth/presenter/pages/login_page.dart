import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tabnews_app/features/auth/presenter/cubit/auth_cubit.dart';
import 'package:tabnews_app/libraries/common/design/app_colors.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final AuthCubit cubit = Modular.get<AuthCubit>();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return ScreenUtilInit(
        designSize: Size(screenSize.width, screenSize.height),
        builder: (context, widget) {
          return BlocBuilder<AuthCubit, AuthState>(
            bloc: cubit,
            builder: (context, state) {
              if (state is AuthInitial) {
                return SafeArea(
                  child: Scaffold(
                    backgroundColor: AppColors.darkGrey,
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 30.h, bottom: 60.h),
                            child: Image.asset(
                                'lib/assets/images/TabNewsLogo.png'),
                          ),
                        ),
                        _body(),
                        _footer(),
                      ],
                    ),
                  ),
                );
              } else if (state is AuthLoading) {
                return Container(
                  color: AppColors.darkGrey,
                  child: const Center(child: CircularProgressIndicator()),
                );
              } else {
                return Container();
              }
            },
          );
        });
  }

  Widget _body() {
    return Column(
      children: [
        Text(
          'Login',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 40.r,
          ),
        ),
        // TODO fazer um widget em um arquivo separado para o textformfield para usar aq e n repetir código
        TextFormField(
          controller: cubit.loginEmailController,
        ),
        TextFormField(
          controller: cubit.loginPasswordController,
        ),
        _logginButton()
      ],
    );
  }

  Widget _logginButton() {
    return Padding(
      padding: EdgeInsets.only(top: 20.h, bottom: 40.h),
      child: GestureDetector(
        onTap: () async {
          await cubit.login();
          Modular.to.pushReplacementNamed('/tabs-module/');
        },
        child: Container(
          height: 50.h,
          width: 150.w,
          decoration: BoxDecoration(
            color: AppColors.green,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              'Fazer login',
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.r,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _footer() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Novo no TabNews?',
              style: TextStyle(color: AppColors.white),
            ),
            TextButton(onPressed: () {}, child: const Text('Registre-se aqui!'))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Esqueceu sua senha?',
              style: TextStyle(color: AppColors.white),
            ),
            TextButton(onPressed: () {}, child: const Text('Recupere-a aqui!'))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Image.asset(
                'lib/assets/images/TabNewsIcon.png',
                height: 24,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              '© 2022 TabNews',
              style: TextStyle(color: AppColors.white),
            ),
          ],
        ),
      ],
    );
  }
}

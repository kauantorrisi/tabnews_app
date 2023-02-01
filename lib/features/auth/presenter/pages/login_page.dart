import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tabnews_app/features/auth/presenter/cubit/auth_cubit.dart';
import 'package:tabnews_app/features/auth/presenter/widgets/tn_textfield_widget.dart';
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
          return SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: AppColors.darkGrey,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 30.h, bottom: 60.h),
                      child: Image.asset('lib/assets/images/TabNewsLogo.png'),
                    ),
                  ),
                  const Spacer(),
                  _body(),
                  const Spacer(flex: 2),
                  _footer(),
                  const Spacer(),
                ],
              ),
            ),
          );
        });
  }

  Widget _body() {
    final textfieldIsEmpty = cubit.loginEmailController.text.isEmpty ||
            cubit.loginPasswordController.text.isEmpty
        ? true
        : false;

    return BlocBuilder<AuthCubit, AuthState>(
      bloc: cubit,
      builder: (context, state) {
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
            const SizedBox(height: 30),
            TNTextField(
              enabledBorderColor:
                  state is LoginEmailException || state is LoginError
                      ? AppColors.red
                      : AppColors.black,
              prefixIcon: Icons.email,
              controller: cubit.loginEmailController,
              obscureText: false,
              hintText: 'E-mail',
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 10),
            TNTextField(
              enabledBorderColor:
                  state is LoginPasswordException || state is LoginError
                      ? AppColors.red
                      : AppColors.black,
              prefixIcon: Icons.lock,
              suffixIcon:
                  cubit.obscureText ? Icons.visibility : Icons.visibility_off,
              controller: cubit.loginPasswordController,
              obscureText: cubit.obscureText,
              onPressedInVisibilityButton: () {
                // It's changing the FocusScope because otherwise it doesn't update the state, so it doesn't change the obscureText.
                if (FocusScope.of(context).hasFocus) {
                  cubit.toggleObscureText;
                  return FocusScope.of(context).unfocus();
                } else {
                  cubit.toggleObscureText;
                  return FocusScope.of(context).requestFocus();
                }
              },
              hintText: 'Senha',
              textInputAction: TextInputAction.done,
            ),
            if (state is LoginEmailException)
              _errorMessage(message: 'Digite um emal válido!'),
            if (state is LoginPasswordException)
              _errorMessage(message: 'Sua senha está incorreta!'),
            if (state is LoginError)
              _errorMessage(
                  message:
                      'Ocorreu um erro durante a tentativa de\nfazer login, tente novamente mais tarde!'),
            Padding(
              padding: EdgeInsets.only(
                top: state is LoginEmailException ||
                        state is LoginPasswordException
                    ? 20
                    : state is LoginError
                        ? 10
                        : 40,
              ),
              child: _logginButton(
                state: state,
                textfieldIsEmpty: textfieldIsEmpty,
                color: textfieldIsEmpty
                    ? AppColors.darkGreen
                    : state is LoginLoading
                        ? AppColors.grey
                        : state is LoginError
                            ? AppColors.red
                            : AppColors.green,
                widget: state is LoginLoading
                    ? CircularProgressIndicator(
                        color: AppColors.green,
                        strokeWidth: 3,
                      )
                    : Text(
                        'Fazer login',
                        style: TextStyle(
                          color: textfieldIsEmpty
                              ? AppColors.white.withAlpha(100)
                              : AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.r,
                        ),
                      ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _errorMessage({required String message}) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Text(
        message,
        style: TextStyle(
          color: AppColors.red.withBlue(80),
          fontWeight: FontWeight.w600,
          fontSize: 14.r,
        ),
      ),
    );
  }

  Widget _logginButton({
    required Widget widget,
    required Color color,
    required AuthState state,
    required bool textfieldIsEmpty,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h, bottom: 40.h),
      child: GestureDetector(
        onTap: () async {
          await cubit.login();
        },
        child: Container(
          height: 50.h,
          width: 150.w,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: widget,
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
        Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 20),
          child: Row(
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
        ),
      ],
    );
  }
}

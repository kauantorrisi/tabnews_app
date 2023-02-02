import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tabnews_app/app/features/auth/presenter/cubit/auth_cubit.dart';
import 'package:tabnews_app/app/features/auth/presenter/widgets/tn_appbar_widget.dart';
import 'package:tabnews_app/app/features/auth/presenter/widgets/tn_button_widget.dart';
import 'package:tabnews_app/app/features/auth/presenter/widgets/tn_error_message_widget.dart';
import 'package:tabnews_app/app/features/auth/presenter/widgets/tn_textfield_widget.dart';
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
              appBar: const PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: TNAppBarWidget(
                  paddingHorizontal: 110,
                  haveImage: true,
                  haveCoins: false,
                ),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(flex: 4),
                  _body(),
                  const Spacer(flex: 3),
                  _footer(),
                  const Spacer(),
                ],
              ),
            ),
          );
        });
  }

  Widget _body() {
    final bool textfieldIsEmpty = cubit.loginEmailController.text.isEmpty ||
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
              focusedBorderColor:
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
              focusedBorderColor:
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
              const TNErrorMessageWidget(message: 'Digite um emal válido!'),
            if (state is LoginPasswordException)
              const TNErrorMessageWidget(message: 'Sua senha está incorreta!'),
            if (state is LoginError)
              const TNErrorMessageWidget(
                  message:
                      'Ocorreu um erro durante a tentativa de\nfazer login, tente novamente mais tarde!'),
            TNButtonWidget(
              onTap: () async {
                FocusScope.of(context).unfocus();
                await cubit.login();
              },
              margin: EdgeInsets.only(
                top: state is LoginEmailException ||
                        state is LoginPasswordException
                    ? 20
                    : state is LoginError
                        ? 10
                        : 40,
              ),
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
          ],
        );
      },
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
            TextButton(
              onPressed: () =>
                  Modular.to.pushReplacementNamed('/register-page'),
              child: const Text('Registre-se aqui!'),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Esqueceu sua senha?',
              style: TextStyle(color: AppColors.white),
            ),
            TextButton(
                onPressed: () =>
                    Modular.to.pushNamed('/recovery-password-page'),
                child: const Text('Recupere-a aqui!'))
          ],
        ),
      ],
    );
  }
}

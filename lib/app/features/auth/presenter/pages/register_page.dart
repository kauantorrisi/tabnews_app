import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tabnews_app/app/features/auth/presenter/cubit/auth_cubit.dart';
import 'package:tabnews_app/app/widgets/tn_appbar_widget.dart';
import 'package:tabnews_app/app/widgets/tn_button_widget.dart';
import 'package:tabnews_app/app/features/auth/presenter/widgets/tn_error_message_widget.dart';
import 'package:tabnews_app/app/features/auth/presenter/widgets/tn_textfield_of_auth_module_widget.dart';
import 'package:tabnews_app/libraries/common/design/app_colors.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final AuthCubit cubit = Modular.get<AuthCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.darkGrey,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: TNAppBarWidget(haveImage: true, haveCoins: false),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(flex: 2),
          _body(),
          const Spacer(flex: 2),
          _footer(),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _body() {
    return BlocBuilder<AuthCubit, AuthState>(
      bloc: cubit,
      builder: (context, state) {
        return Column(
          children: [
            Center(
              child: Text(
                'Registro',
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40.r,
                ),
              ),
            ),
            const SizedBox(height: 30),
            textfieldsAndButton(context, state),
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
              'Já tem uma conta no TabNews?',
              style: TextStyle(color: AppColors.white),
            ),
            TextButton(
              onPressed: () =>
                  Modular.to.pushReplacementNamed('/auth-module/login-page'),
              child: const Text('Faça Login!'),
            )
          ],
        ),
      ],
    );
  }

  Widget textfieldsAndButton(BuildContext context, AuthState state) {
    final bool textfieldsIsEmpty =
        cubit.registerUsernameController.text.isEmpty ||
                cubit.registerEmailController.text.isEmpty ||
                cubit.registerPasswordController.text.isEmpty
            ? true
            : false;

    return Column(
      children: [
        TNTextfieldOfAuthModuleWidget(
          controller: cubit.registerUsernameController,
          prefixIcon: Icons.person,
          enabledBorderColor: state is RegisterEmptyUsernameException ||
                  state is RegisterUsernameAlreadyTakenException
              ? AppColors.red
              : AppColors.black,
          focusedBorderColor: state is RegisterEmptyUsernameException ||
                  state is RegisterUsernameAlreadyTakenException
              ? AppColors.red
              : AppColors.black,
          obscureText: false,
          hintText: 'Nome de usuário',
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 10),
        TNTextfieldOfAuthModuleWidget(
          controller: cubit.registerEmailController,
          prefixIcon: Icons.email,
          enabledBorderColor: state is RegisterEmailException ||
                  state is RegisterEmailAlreadyTakenException
              ? AppColors.red
              : AppColors.black,
          focusedBorderColor: state is RegisterEmailException ||
                  state is RegisterEmailAlreadyTakenException
              ? AppColors.red
              : AppColors.black,
          obscureText: false,
          hintText: 'E-mail',
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 10),
        TNTextfieldOfAuthModuleWidget(
          controller: cubit.registerPasswordController,
          prefixIcon: Icons.lock,
          suffixIcon:
              cubit.obscureText ? Icons.visibility : Icons.visibility_off,
          enabledBorderColor: state is RegisterPasswordException
              ? AppColors.red
              : AppColors.black,
          focusedBorderColor: state is RegisterPasswordException
              ? AppColors.red
              : AppColors.black,
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
        if (state is RegisterEmptyUsernameException)
          const TNErrorMessageWidget(
              message: 'O nome de usuário não pode estar em branco'),
        if (state is RegisterUsernameAlreadyTakenException)
          const TNErrorMessageWidget(
              message: 'Esse nome de usuário já está em uso'),
        if (state is RegisterEmailException)
          const TNErrorMessageWidget(message: 'Digite um e-mail válido'),
        if (state is RegisterEmailAlreadyTakenException)
          const TNErrorMessageWidget(message: 'Esse e-mail já está em uso'),
        if (state is RegisterPasswordException)
          const TNErrorMessageWidget(
              message: 'A senha deve conter no mínimo 8 caracteres'),
        if (state is RegisterError)
          const TNErrorMessageWidget(
              message:
                  'Ocorreu um erro interno, tente se registrar novamente!'),
        TNButtonWidget(
          onTap: () async {
            FocusScope.of(context).unfocus();
            await cubit.register(context);
          },
          color: textfieldsIsEmpty
              ? AppColors.grey
              : state is RegisterLoading
                  ? AppColors.darkGreen
                  : AppColors.green,
          widget: state is RegisterLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.green,
                  ),
                )
              : Text(
                  'Registre-se',
                  style: TextStyle(
                    color: textfieldsIsEmpty
                        ? AppColors.white.withAlpha(100)
                        : AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.r,
                  ),
                ),
          margin: const EdgeInsets.only(top: 40),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tabnews_app/features/auth/presenter/cubit/auth_cubit.dart';
import 'package:tabnews_app/features/auth/presenter/widgets/tn_appbar_widget.dart';
import 'package:tabnews_app/features/auth/presenter/widgets/tn_button_widget.dart';
import 'package:tabnews_app/features/auth/presenter/widgets/tn_textfield_widget.dart';
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
        child: TNAppBarWidget(
          paddingHorizontal: 100,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(flex: 4),
          _body(),
          const Spacer(flex: 2),
          _footer(),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _body() {
    final bool textfieldsIsEmpty =
        cubit.registerUsernameController.text.isEmpty &&
                cubit.registerEmailController.text.isEmpty &&
                cubit.registerPasswordController.text.isEmpty
            ? true
            : false;

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
            TNTextField(
              controller: cubit.registerUsernameController,
              prefixIcon: Icons.person,
              enabledBorderColor: state is RegisterEmptyUsernameException ||
                      state is RegisterUsernameAlreadyTakenException
                  ? AppColors.red
                  : AppColors.white,
              obscureText: false,
              hintText: 'Nome de usuário',
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 10),
            TNTextField(
              controller: cubit.registerEmailController,
              prefixIcon: Icons.email,
              enabledBorderColor: state is RegisterEmailException ||
                      state is RegisterEmailAlreadyTakenException
                  ? AppColors.red
                  : AppColors.white,
              obscureText: false,
              hintText: 'E-mail',
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 10),
            TNTextField(
              controller: cubit.registerPasswordController,
              prefixIcon: Icons.lock,
              suffixIcon:
                  cubit.obscureText ? Icons.visibility : Icons.visibility_off,
              enabledBorderColor: state is RegisterPasswordException
                  ? AppColors.red
                  : AppColors.white,
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
            const SizedBox(height: 30),
            TNButtonWidget(
              onTap: () async {
                await cubit.register();
              },
              color: textfieldsIsEmpty
                  ? AppColors.darkGreen
                  : state is RegisterLoading
                      ? AppColors.grey
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
                  Modular.to.pushReplacementNamed(Modular.initialRoute),
              child: const Text('Faça Login!'),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100),
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

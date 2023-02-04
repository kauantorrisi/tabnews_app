import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tabnews_app/app/features/auth/presenter/cubit/auth_cubit.dart';
import 'package:tabnews_app/app/features/auth/presenter/widgets/tn_appbar_widget.dart';
import 'package:tabnews_app/app/features/auth/presenter/widgets/tn_button_widget.dart';
import 'package:tabnews_app/app/features/auth/presenter/widgets/tn_error_message_widget.dart';
import 'package:tabnews_app/app/features/auth/presenter/widgets/tn_textfield_widget.dart';
import 'package:tabnews_app/libraries/common/design/app_colors.dart';

class RecoveryPasswordPage extends StatelessWidget {
  const RecoveryPasswordPage({super.key, required this.cubit});

  final AuthCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: TNAppBarWidget(haveImage: false, haveCoins: false),
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        bloc: cubit,
        builder: (context, state) {
          final bool textfieldIsEmpty =
              cubit.recoveryPasswordController.text.isEmpty ? true : false;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Center(
                child: Text(
                  'Recuperação de senha',
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 34.r,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              TNTextField(
                enabledBorderColor: state is RecoveryPasswordEmailException ||
                        state is RecoveryPasswordEmailNotFoundException ||
                        state is RecoveryPasswordError
                    ? AppColors.red
                    : AppColors.black,
                focusedBorderColor: state is RecoveryPasswordEmailException ||
                        state is RecoveryPasswordEmailNotFoundException ||
                        state is RecoveryPasswordError
                    ? AppColors.red
                    : AppColors.black,
                prefixIcon: Icons.email,
                controller: cubit.recoveryPasswordController,
                obscureText: false,
                hintText: 'E-mail',
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 30),
              if (state is RecoveryPasswordEmailException)
                const TNErrorMessageWidget(message: 'Digite um e-mail válido!'),
              if (state is RecoveryPasswordEmailNotFoundException)
                const TNErrorMessageWidget(
                    message:
                        'O E-mail informado não foi encontrado no sistema!'),
              TNButtonWidget(
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  await cubit.recoveryPassword(context);
                },
                color: textfieldIsEmpty
                    ? AppColors.darkGreen
                    : state is RecoveryPasswordLoading
                        ? AppColors.darkGrey
                        : AppColors.green,
                widget: state is RecoveryPasswordLoading
                    ? CircularProgressIndicator(
                        color: AppColors.green,
                        strokeWidth: 3,
                      )
                    : Text(
                        'Recuperar senha',
                        style: TextStyle(
                          color: textfieldIsEmpty
                              ? AppColors.white.withAlpha(100)
                              : AppColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.r,
                        ),
                      ),
                margin: const EdgeInsets.only(top: 40),
              ),
              const Spacer(),
            ],
          );
        },
      ),
    );
  }
}

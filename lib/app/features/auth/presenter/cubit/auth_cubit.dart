// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:tabnews_app/app/core/errors/app_failures.dart';
import 'package:tabnews_app/app/features/auth/domain/entities/login_entity.dart';
import 'package:tabnews_app/app/features/auth/domain/entities/recovery_password_entity.dart';
import 'package:tabnews_app/app/domain/entities/user_entity.dart';
import 'package:tabnews_app/app/domain/usecases/get_user_usecase.dart';
import 'package:tabnews_app/app/features/auth/domain/usecases/login_usecase.dart';
import 'package:tabnews_app/app/features/auth/domain/usecases/recovery_password_usecase.dart';
import 'package:tabnews_app/app/features/auth/domain/usecases/register_usecase.dart';
import 'package:tabnews_app/app/features/auth/presenter/widgets/tn_register_and_recovery_password_alert_dialog_widget.dart';
import 'package:tabnews_app/app/features/auth/services/auth_prefs_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    this.loginUsecase,
    this.registerUsecase,
    this.recoveryPasswordUsecase,
    this.getUserUsecase,
  ) : super(AuthInitial());

  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();
  final TextEditingController registerUsernameController =
      TextEditingController();
  final TextEditingController registerEmailController = TextEditingController();
  final TextEditingController registerPasswordController =
      TextEditingController();

  final TextEditingController recoveryPasswordController =
      TextEditingController();
  bool obscureText = true;

  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;
  final GetUserUsecase getUserUsecase;
  final RecoveryPasswordUsecase recoveryPasswordUsecase;

  LoginEntity? loginEntity;
  RecoveryPasswordEntity? recoveryPasswordEntity;
  UserEntity? userEntity;

  bool isGuest = false;

  bool toggleIsGuest(bool value) => isGuest = value;

  bool get toggleObscureText {
    return obscureText = !obscureText;
  }

  Future<void> login() async {
    emit(LoginLoading());
    final result = await loginUsecase(LoginParams(
      email: loginEmailController.text,
      password: loginPasswordController.text,
    ));
    result.fold(
      (l) {
        if (l == ServerFailure('"email" deve conter um email válido.') ||
            l == ServerFailure('"email" não pode estar em branco.')) {
          emit(LoginEmailException());
        } else if (l == ServerFailure("Dados não conferem.") ||
            l == ServerFailure('"password" não pode estar em branco.') ||
            l ==
                ServerFailure(
                    '"password" deve conter no mínimo 8 caracteres.')) {
          emit(LoginPasswordException());
        } else {
          emit(LoginError());
        }
      },
      (r) async {
        loginEntity = r;
        await getUser(loginEntity!.token);
        AuthPrefsService.save(
          token: loginEntity!.token,
          username: userEntity!.username,
          email: userEntity!.email,
          tabCoins: userEntity!.tabcoins,
          tabCash: userEntity!.tabcash,
          isGuest: isGuest,
        );
        Modular.to.pushReplacementNamed('/tabs-module/', arguments: {
          "token": loginEntity!.token,
          "username": userEntity!.username,
          "tabcoins": userEntity!.tabcoins,
          "tabcash": userEntity!.tabcash,
          "isGuest": isGuest,
        });
        loginEmailController.text = '';
        loginPasswordController.text = '';
      },
    );
  }

  Future<void> register(BuildContext context) async {
    emit(RegisterLoading());
    final result = await registerUsecase(RegisterParams(
      registerUsernameController.text,
      registerEmailController.text,
      registerPasswordController.text,
    ));
    result.fold(
      (l) {
        if (l == ServerFailure('"username" não pode estar em branco.')) {
          emit(RegisterEmptyUsernameException());
        } else if (l ==
            ServerFailure('O "username" informado já está sendo usado.')) {
          emit(RegisterUsernameAlreadyTakenException());
        } else if (l == ServerFailure('"email" não pode estar em branco.') ||
            l == ServerFailure('"email" deve conter um email válido.')) {
          emit(RegisterEmailException());
        } else if (l ==
            ServerFailure('O email informado já está sendo usado.')) {
          emit(RegisterEmailAlreadyTakenException());
        } else if (l == ServerFailure('"password" não pode estar em branco.') ||
            l ==
                ServerFailure(
                    '"password" deve conter no mínimo 8 caracteres.')) {
          emit(RegisterPasswordException());
        } else {
          emit(RegisterError());
        }
      },
      (r) async {
        emit(RegisteredSuccessful());
        if (state is RegisteredSuccessful) {
          await showDialog(
            context: context,
            builder: (context) => TNAlertDialogWidget(
              userEmail: registerEmailController.text,
              textContent:
                  'Você irá receber um e-mail para confirmar seu registro e ativar a sua conta.',
            ),
          );
          registerEmailController.text = '';
          registerPasswordController.text = '';
          registerUsernameController.text = '';
        }
      },
    );
  }

  Future<void> recoveryPassword(BuildContext context) async {
    emit(RecoveryPasswordLoading());
    final result = await recoveryPasswordUsecase(
        RecoveryPasswordParams(recoveryPasswordController.text));
    result.fold((l) {
      if (l == ServerFailure('"email" deve conter um email válido.')) {
        emit(RecoveryPasswordEmailException());
      } else if (l ==
          ServerFailure('O "email" informado não foi encontrado no sistema.')) {
        emit(RecoveryPasswordEmailNotFoundException());
      } else {
        emit(RecoveryPasswordError());
      }
    }, (r) async {
      emit(RecoveryPasswordSuccessful());
      if (state is RecoveryPasswordSuccessful) {
        await showDialog(
          context: context,
          builder: (context) => TNAlertDialogWidget(
            userEmail: recoveryPasswordController.text,
            textContent:
                'Você irá receber um e-mail para poder recuperar sua senha',
          ),
        );
      }
      recoveryPasswordEntity = r;
      recoveryPasswordController.text = '';
    });
  }

  Future<void> getUser(String token) async {
    emit(LoginLoading());
    final result = await getUserUsecase(UserParams(token));
    result.fold((l) => emit(LoginError()), (r) {
      userEntity = r;
    });
  }
}

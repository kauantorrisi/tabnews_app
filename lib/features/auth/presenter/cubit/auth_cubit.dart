// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:tabnews_app/core/errors/app_failures.dart';
import 'package:tabnews_app/features/auth/domain/entities/login_entity.dart';
import 'package:tabnews_app/features/auth/domain/entities/recovery_password_entity.dart';
import 'package:tabnews_app/features/auth/domain/entities/register_entity.dart';
import 'package:tabnews_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:tabnews_app/features/auth/domain/usecases/recovery_password_usecase.dart';
import 'package:tabnews_app/features/auth/domain/usecases/register_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.loginUsecase,
    required this.registerUsecase,
    required this.recoveryPasswordUsecase,
  }) : super(AuthInitial());

  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();

  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;
  final RecoveryPasswordUsecase recoveryPasswordUsecase;

  LoginEntity? loginEntity;
  RegisterEntity? registerEntity;
  RecoveryPasswordEntity? recoveryPasswordEntity;

  Future<void> login() async {
    emit(AuthLoading());
    final result = await loginUsecase(LoginParams(
      email: loginEmailController.text,
      password: loginPasswordController.text,
    ));
    result.fold(
      (l) {
        if (l == ServerFailure('"email" deve conter um email válido.')) {
          emit(AuthEmailException());
        } else if (l == ServerFailure("Dados não conferem.")) {
          emit(AuthPasswordException());
        } else {
          emit(AuthError());
        }
      },
      (r) {
        loginEntity = r;
        Modular.to.pushReplacementNamed('/tabs-module/');
      },
    );
  }

  Future<void> register({
    required String username,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    final result =
        await registerUsecase(RegisterParams(username, email, password));
    result.fold(
      (l) => emit(AuthError()),
      (r) => registerEntity = r,
    );
  }

  Future<void> recoveryPassword({required String emailOrUsername}) async {
    emit(AuthLoading());
    final result =
        await recoveryPasswordUsecase(RecoveryPasswordParams(emailOrUsername));
    result.fold(
      (l) => emit(AuthError()),
      (r) => recoveryPasswordEntity = r,
    );
  }
}

// ignore_for_file: unused_local_variable

import 'package:dio/dio.dart';

import 'package:tabnews_app/app/core/errors/app_exceptions.dart';
import 'package:tabnews_app/app/features/auth/data/models/login_model.dart';
import 'package:tabnews_app/app/features/auth/data/models/recovery_password_model.dart';
import 'package:tabnews_app/app/data/models/user_model.dart';
import 'package:tabnews_app/libraries/common/constants.dart';

abstract class IAuthDatasource {
  Future<LoginModel> login(String email, String password);
  Future<void> register(String username, String email, String password);
  Future<RecoveryPasswordModel> recoveryPassword(String emailOrUsername);
}

class AuthDatasource implements IAuthDatasource {
  final Dio dio = Dio();

  @override
  Future<LoginModel> login(String email, String password) async {
    Response result = await dio.post(loginUrl,
        options: Options(contentType: 'application/json'),
        data: {
          "email": email,
          "password": password,
        });
    Map<String, dynamic> response = result.data;
    if (result.statusCode == 201) {
      final LoginModel loginModel = LoginModel.fromJson(response);
      return loginModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> register(String username, String email, String password) async {
    Response result = await dio.post(registerUrl,
        options: Options(contentType: 'application/json'),
        data: {
          "username": username,
          "email": email,
          "password": password,
        });
    if (result.statusCode == 401 || result.statusCode == 400) {
      throw ServerException();
    }
  }

  @override
  Future<RecoveryPasswordModel> recoveryPassword(String emailOrUsername) async {
    Response result = await dio.post(recoveryPasswordUrl,
        options: Options(contentType: 'application/json'),
        data: {
          "email": emailOrUsername,
          "username": emailOrUsername,
        });
    Map<String, dynamic> response = result.data;
    if (result.statusCode == 201) {
      final RecoveryPasswordModel recoveryPasswordModel =
          RecoveryPasswordModel.fromJson(response);
      return recoveryPasswordModel;
    } else {
      throw ServerException();
    }
  }
}

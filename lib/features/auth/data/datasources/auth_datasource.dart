import 'package:dio/dio.dart';

import 'package:tabnews_app/core/errors/app_exceptions.dart';
import 'package:tabnews_app/features/auth/data/models/login_model.dart';
import 'package:tabnews_app/features/auth/data/models/recovery_password_model.dart';
import 'package:tabnews_app/features/auth/data/models/register_model.dart';
import 'package:tabnews_app/libraries/common/constants.dart';

abstract class IAuthDatasource {
  Future<LoginModel> login(String email, String password);
  Future<RegisterModel> register(
      String username, String email, String password);
  Future<RecoveryPasswordModel> recoveryPassword(String emailOrUsername);
}

class AuthDatasource implements IAuthDatasource {
  final Dio dio = Dio();

  @override
  Future<LoginModel> login(String email, String password) async {
    Response result = await dio.post(
      loginUrl,
      options: Options(contentType: 'application/json'),
      data: {
        "email": email,
        "password": password,
      },
    );
    Map<String, dynamic> response = result.data;
    if (result.statusCode == 201) {
      final LoginModel loginModel = LoginModel.fromJson(response);
      return loginModel;
    } else {
      throw ServerException();
    }
  }

  @override // TODO: AJEITAR REQUISIÇÃO PASSANDO BODY
  Future<RegisterModel> register(
      String username, String email, String password) async {
    Response result = await dio.post(registerUrl);
    Map<String, dynamic> response = result.data;
    if (result.statusCode == 201) {
      final RegisterModel registerModel = RegisterModel.fromJson(response);
      return registerModel;
    } else {
      throw ServerException();
    }
  }

  @override // TODO: AJEITAR REQUISIÇÃO PASSANDO BODY
  Future<RecoveryPasswordModel> recoveryPassword(String emailOrUsername) async {
    Response result = await dio.post(recoveryPasswordUrl);
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

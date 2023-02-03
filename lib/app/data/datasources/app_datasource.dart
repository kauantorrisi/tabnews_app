// ignore_for_file: unused_local_variable

import 'package:dio/dio.dart';

import 'package:tabnews_app/app/core/errors/app_exceptions.dart';
import 'package:tabnews_app/app/data/models/user_model.dart';
import 'package:tabnews_app/libraries/common/constants.dart';

abstract class IAppDatasource {
  Future<UserModel> getUser(String token);
}

class AppDatasource implements IAppDatasource {
  final Dio dio = Dio();

  @override
  Future<UserModel> getUser(String token) async {
    final UserModel userModel;
    Response results = await dio.get(getUserUrl,
        options: Options(
          headers: {
            "cookie": "session_id=$token",
          },
        ));
    if (results.statusCode == 200) {
      return userModel = UserModel.fromJson(results.data);
    } else {
      throw ServerException();
    }
  }
}

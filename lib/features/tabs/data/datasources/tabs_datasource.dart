// ignore_for_file: unused_local_variable

import 'package:dio/dio.dart';

import 'package:tabnews_app/core/errors/app_exceptions.dart';
import 'package:tabnews_app/features/tabs/data/models/tab_model.dart';
import 'package:tabnews_app/features/tabs/data/models/user_model.dart';
import 'package:tabnews_app/libraries/common/constants.dart';

abstract class ITabsDatasource {
  Future<List<TabModel>> getAllTabs(int page, int perPage, String strategy);
  Future<TabModel> getTab(String ownerUsername, String slug);
  Future<List<TabModel>> getTabComments(String ownerUsername, String slug);
  Future<UserModel> getUser(String token);
}

class TabsDatasource implements ITabsDatasource {
  final Dio dio = Dio();

  @override
  Future<List<TabModel>> getAllTabs(
      int page, int perPage, String strategy) async {
    List<TabModel> tabsList = [];
    Response result = await dio
        .get('$getContentsUrl?page=$page&per_page=$perPage&strategy=$strategy');
    List<dynamic> response = result.data;
    if (result.statusCode == 200) {
      for (var tab in response) {
        tabsList.add(TabModel.fromMap(tab));
      }
      return tabsList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TabModel> getTab(String ownerUsername, String slug) async {
    Response result = await dio.get('$getContentsUrl/$ownerUsername/$slug');
    if (result.statusCode == 200) {
      TabModel tabModel = TabModel.fromMap(result.data);
      return tabModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TabModel>> getTabComments(
      String ownerUsername, String slug) async {
    List<TabModel> tabsList = [];
    Response results =
        await dio.get('$getContentsUrl/$ownerUsername/$slug/children');
    List<dynamic> response = results.data;
    if (results.statusCode == 200) {
      for (var content in response) {
        tabsList.add(TabModel.fromMap(content));
      }
    } else {
      throw ServerException();
    }
    return tabsList;
  }

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

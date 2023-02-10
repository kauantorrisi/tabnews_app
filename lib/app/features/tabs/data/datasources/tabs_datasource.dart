// ignore_for_file: unused_local_variable

import 'package:dio/dio.dart';

import 'package:tabnews_app/app/core/errors/app_exceptions.dart';
import 'package:tabnews_app/app/features/tabs/data/models/tab_model.dart';
import 'package:tabnews_app/libraries/common/constants.dart';

abstract class ITabsDatasource {
  Future<List<TabModel>> getAllTabs(int page, int perPage, String strategy);
  Future<TabModel> getTab(String ownerUsername, String slug);
  Future<List<TabModel>> getTabComments(String ownerUsername, String slug);
  Future<TabModel> postTab(String title, String body, String status,
      String sourceUrl, String slug, String token);
}

class TabsDatasource implements ITabsDatasource {
  final Dio dio = Dio();

  @override
  Future<List<TabModel>> getAllTabs(
      int page, int perPage, String strategy) async {
    List<TabModel> tabsList = [];
    Response result = await dio
        .get(getContentsUrl(page: page, perPage: perPage, strategy: strategy));
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
    Response result =
        await dio.get(getTabUrl(ownerUsername: ownerUsername, slug: slug));
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
    Response results = await dio
        .get(getTabCommentsUrl(ownerUsername: ownerUsername, slug: slug));
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
  Future<TabModel> postTab(String title, String body, String status,
      String sourceUrl, String slug, String token) async {
    TabModel tabModel;
    Response results = await dio.post(postContentUrl,
        data: {
          "title": title,
          "body": body,
          "status": status,
          "source_url": sourceUrl,
          "slug": slug
        },
        options: Options(
          contentType: 'application/json',
          headers: {"session_id": token},
        ));
    final response = results.data;
    if (results.statusCode == 201) {
      tabModel = TabModel.fromJson(response);
    } else {
      throw ServerException();
    }
    return tabModel;
  }
}

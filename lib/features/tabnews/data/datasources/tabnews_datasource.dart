import 'package:dartz/dartz_unsafe.dart';
import 'package:dio/dio.dart';

import 'package:tabnews_app/core/errors/app_exceptions.dart';
import 'package:tabnews_app/features/tabnews/data/models/tab_model.dart';

abstract class ITabNewsDatasource {
  Future<List<TabModel>> getAllTabs(int page, int perPage, String strategy);
  Future<TabModel> getTab(String ownerUsername, String slug);
  Future<List<TabModel>> getTabComments(String ownerUsername, String slug);
}

class TabNewsDatasource implements ITabNewsDatasource {
  final Dio dio = Dio();

  @override
  Future<List<TabModel>> getAllTabs(
      int page, int perPage, String strategy) async {
    List<TabModel> tabsList = [];
    Response result = await dio.get(
        'https://www.tabnews.com.br/api/v1/contents?page=$page&per_page=$perPage&strategy=$strategy');
    List<dynamic> response = result.data;
    if (result.statusCode == 200) {
      for (var tab in response) {
        tabsList.add(TabModel.fromJson(tab));
      }
      return tabsList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TabModel> getTab(String ownerUsername, String slug) async {
    Response result = await dio
        .get('https://www.tabnews.com.br/api/v1/contents/$ownerUsername/$slug');
    if (result.statusCode == 200) {
      TabModel tabModel = TabModel.fromJson(result.data);
      return tabModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TabModel>> getTabComments(
      String ownerUsername, String slug) async {
    List<TabModel> tabsList = [];
    Response results = await dio.get('');
    List<dynamic> response = results.data;
    if (results.statusCode == 200) {
      for (var tab in response) {
        tabsList.add(tab);
      }
    } else {
      throw ServerException();
    }
    return tabsList;
  }
}

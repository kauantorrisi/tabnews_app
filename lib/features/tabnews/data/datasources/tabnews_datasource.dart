import 'package:dio/dio.dart';

import 'package:tabnews_app/core/errors/app_exceptions.dart';
import 'package:tabnews_app/features/tabnews/data/models/tab_model.dart';

abstract class ITabNewsDatasource {
  Future<List<TabModel>> getAllTabs(int page, int perPage, String strategy);
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
}

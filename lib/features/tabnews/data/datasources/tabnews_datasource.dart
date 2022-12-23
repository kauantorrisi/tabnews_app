import 'package:dio/dio.dart';
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
    Response response = await dio.get(
        'https://www.tabnews.com.br/api/v1/contents?page=$page&per_page=$perPage&strategy=$strategy');
    List<Map<String, dynamic>> results = response.data;
    for (var tab in results) {
      tabsList.add(TabModel.fromJson(tab));
    }
    return tabsList;
  }
}

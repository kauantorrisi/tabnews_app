import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modular_test/modular_test.dart';

import 'package:tabnews_app/app_module.dart';
import 'package:tabnews_app/core/errors/app_failures.dart';
import 'package:tabnews_app/features/tabs/domain/entities/tab_entity.dart';
import 'package:tabnews_app/features/tabs/domain/usecases/get_all_tabs_usecase.dart';

void main() {
  setUp(() {
    initModule(AppModule());
  });

  test('should recover the usecase with no errors', () {
    final GetAllTabsUsecase usecase = Modular.get<GetAllTabsUsecase>();

    expect(usecase, isA<GetAllTabsUsecase>());
  });

  test('should return a List<TabEntity> when the call of usecase is successful',
      () async {
    final GetAllTabsUsecase usecase = Modular.get<GetAllTabsUsecase>();

    final result = await usecase(
        const GetAllTabsParams(page: 1, perPage: 10, strategy: 'relevant'));

    expect(result, isA<Right<Failure, List<TabEntity>>>());
  });
}

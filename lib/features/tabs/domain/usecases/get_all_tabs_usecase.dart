import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:tabnews_app/core/errors/app_failures.dart';
import 'package:tabnews_app/core/usecases/usecase.dart';
import 'package:tabnews_app/features/tabs/domain/entities/tab_entity.dart';
import 'package:tabnews_app/features/tabs/domain/repositories/i_tabnews_repository.dart';

class GetAllTabsUsecase implements Usecase<List<TabEntity>, GetAllTabsParams> {
  final ITabsRepository repository;

  GetAllTabsUsecase(this.repository);

  @override
  Future<Either<Failure, List<TabEntity>>> call(GetAllTabsParams params) async {
    return await repository.getAllTabs(
        params.page, params.perPage, params.strategy);
  }
}

class GetAllTabsParams extends Equatable {
  final int page;
  final int perPage;
  final String strategy;

  const GetAllTabsParams(
      {required this.page, required this.perPage, required this.strategy});

  @override
  List<Object?> get props => [page, perPage, strategy];
}

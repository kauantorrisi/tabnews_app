import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:tabnews_app/core/errors/app_failures.dart';
import 'package:tabnews_app/core/usecases/usecase.dart';
import 'package:tabnews_app/features/tabnews/domain/entities/tab_entity.dart';
import 'package:tabnews_app/features/tabnews/domain/repositories/i_tabnews_repository.dart';

class GetAllTabsUsecase implements Usecase<List<TabEntity>, Params> {
  final ITabNewsRepository repository;

  GetAllTabsUsecase(this.repository);

  @override
  Future<Either<Failure, List<TabEntity>>> call(Params params) async {
    return await repository.getAllTabs(
        params.page, params.perPage, params.strategy);
  }
}

class Params extends Equatable {
  final int page;
  final int perPage;
  final String strategy;

  const Params(
      {required this.page, required this.perPage, required this.strategy});

  @override
  List<Object?> get props => [page, perPage, strategy];
}

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:tabnews_app/app/core/errors/app_failures.dart';
import 'package:tabnews_app/app/core/usecases/usecase.dart';
import 'package:tabnews_app/app/features/tabs/domain/entities/tab_entity.dart';
import 'package:tabnews_app/app/features/tabs/domain/repositories/i_tabs_repository.dart';

class GetTabUsecase implements Usecase<TabEntity, GetTabParams> {
  final ITabsRepository repository;

  GetTabUsecase(this.repository);

  @override
  Future<Either<Failure, TabEntity>> call(GetTabParams params) async {
    return await repository.getTab(params.ownerUsername, params.slug);
  }
}

class GetTabParams extends Equatable {
  final String ownerUsername;
  final String slug;

  const GetTabParams({required this.ownerUsername, required this.slug});

  @override
  List<Object?> get props => [ownerUsername, slug];
}

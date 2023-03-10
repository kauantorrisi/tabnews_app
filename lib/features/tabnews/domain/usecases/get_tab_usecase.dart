import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:tabnews_app/core/errors/app_failures.dart';
import 'package:tabnews_app/core/usecases/usecase.dart';
import 'package:tabnews_app/features/tabnews/domain/entities/tab_entity.dart';
import 'package:tabnews_app/features/tabnews/domain/repositories/i_tabnews_repository.dart';

class GetTabUsecase implements Usecase<TabEntity, GetTabParams> {
  final ITabNewsRepository repository;

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

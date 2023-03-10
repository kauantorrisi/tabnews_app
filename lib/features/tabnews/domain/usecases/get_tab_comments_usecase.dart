import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:tabnews_app/core/errors/app_failures.dart';
import 'package:tabnews_app/core/usecases/usecase.dart';
import 'package:tabnews_app/features/tabnews/domain/entities/tab_entity.dart';
import 'package:tabnews_app/features/tabnews/domain/repositories/i_tabnews_repository.dart';

class GetTabCommentsUsecase
    implements Usecase<List<TabEntity>, GetTabCommentsParams> {
  final ITabNewsRepository repository;

  GetTabCommentsUsecase(this.repository);

  @override
  Future<Either<Failure, List<TabEntity>>> call(
      GetTabCommentsParams params) async {
    return await repository.getTabComments(params.ownerUsername, params.slug);
  }
}

class GetTabCommentsParams extends Equatable {
  final String ownerUsername;
  final String slug;

  const GetTabCommentsParams({required this.ownerUsername, required this.slug});

  @override
  List<Object?> get props => [ownerUsername, slug];
}

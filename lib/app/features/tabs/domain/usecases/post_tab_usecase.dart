import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:tabnews_app/app/core/errors/app_failures.dart';
import 'package:tabnews_app/app/core/usecases/usecase.dart';
import 'package:tabnews_app/app/features/tabs/domain/entities/tab_entity.dart';
import 'package:tabnews_app/app/features/tabs/domain/repositories/i_tabs_repository.dart';

class PostTabUsecase implements Usecase<TabEntity, PostTabParams> {
  final ITabsRepository repository;

  PostTabUsecase(this.repository);

  @override
  Future<Either<Failure, TabEntity>> call(PostTabParams params) {
    return repository.postTab(params.title, params.body, params.status);
  }
}

class PostTabParams extends Equatable {
  final String title;
  final String body;
  final String status;

  const PostTabParams(this.title, this.body, this.status);

  @override
  List<Object?> get props => [title, body, status];
}

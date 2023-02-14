import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:tabnews_app/app/features/tabs/domain/usecases/post_tab_usecase.dart';
import 'package:tabnews_app/libraries/common/constants.dart';

part 'post_tab_state.dart';

class PostTabCubit extends Cubit<PostTabState> {
  PostTabCubit(this.postTabUsecase) : super(PostTabInitial());

  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  final TextEditingController sourceUrlController = TextEditingController();

  final PostTabUsecase postTabUsecase;

  Future<void> postTab(
      {required String token, required String username}) async {
    emit(PostTabLoading());
    final result = await postTabUsecase(PostTabParams(
      token: token,
      title: titleController.text,
      body: bodyController.text,
      status: 'published',
      sourceUrl: '$baseUrl/$username/',
      slug: titleController.text.replaceAll(RegExp(r' '), '-'),
    ));
    result.fold((l) => emit(PostTabError()), (r) => emit(PostTabSuccessful()));
  }
}

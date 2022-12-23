// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:tabnews_app/features/tabnews/domain/entities/tab_entity.dart';
import 'package:tabnews_app/features/tabnews/domain/usecases/get_all_tabs_usecase.dart';
import 'package:tabnews_app/features/tabnews/domain/usecases/get_tab_comments_usecase.dart';
import 'package:tabnews_app/features/tabnews/domain/usecases/get_tab_usecase.dart';

part 'tabnews_state.dart';

class TabnewsCubit extends Cubit<TabnewsState> {
  final GetAllTabsUsecase getAllTabsUsecase;
  final GetTabCommentsUsecase getTabCommentsUsecase;
  final GetTabUsecase getTabUsecase;

  TabnewsCubit(
    this.getAllTabsUsecase,
    this.getTabCommentsUsecase,
    this.getTabUsecase,
  ) : super(TabnewsInitial());

  List<TabEntity> relevantTabsList = [];
  List<TabEntity> recentTabsList = [];
  late TabEntity tabEntity;
  bool isInRelevantPage = true;

  Future<void> getRelevantTabs() async {
    emit(TabNewsLoading());
    final results = await getAllTabsUsecase(
        const GetAllTabsParams(page: 1, perPage: 30, strategy: 'relevant'));
    if (relevantTabsList.isEmpty) {
      results.forEach((tabList) {
        relevantTabsList.addAll(tabList);
      });
    }
    results.fold((l) => emit(TabNewsError()), (r) => emit(TabNewsSuccessful()));
  }

  Future<void> getRecentTabs() async {
    emit(TabNewsLoading());
    final results = await getAllTabsUsecase(
        const GetAllTabsParams(page: 1, perPage: 30, strategy: 'new'));
    if (recentTabsList.isEmpty) {
      results.forEach((tabList) {
        recentTabsList.addAll(tabList);
      });
    }
    results.fold((l) => emit(TabNewsError()), (r) => emit(TabNewsSuccessful()));
  }

  Future<TabEntity> getTab({required int index}) async {
    emit(TabNewsLoading());
    if (isInRelevantPage == true) {
      final result = await getTabUsecase(GetTabParams(
          ownerUsername: relevantTabsList[index].ownerUsername,
          slug: relevantTabsList[index].slug));
      result.fold((l) => emit(TabNewsError()), (tab) {
        emit(TabNewsSuccessful());
        tabEntity = tab;
      });
    } else {
      final result = await getTabUsecase(GetTabParams(
          ownerUsername: recentTabsList[index].ownerUsername,
          slug: recentTabsList[index].slug));
      result.fold((l) => emit(TabNewsError()), (tab) {
        emit(TabNewsSuccessful());
        tabEntity = tab;
      });
    }
    return tabEntity;
  }
}

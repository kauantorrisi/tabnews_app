// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:tabnews_app/core/errors/app_failures.dart';
import 'package:tabnews_app/features/tabnews/domain/entities/tab_entity.dart';
import 'package:tabnews_app/features/tabnews/domain/usecases/get_all_tabs_usecase.dart';
import 'package:tabnews_app/features/tabnews/domain/usecases/get_tab_comments_usecase.dart';
import 'package:tabnews_app/features/tabnews/domain/usecases/get_tab_usecase.dart';

part 'tabs_state.dart';

class TabsCubit extends Cubit<TabsState> {
  TabsCubit(
    this.getAllTabsUsecase,
    this.getTabCommentsUsecase,
    this.getTabUsecase,
  ) : super(TabsInitial()) {
    getRelevantTabs();
    getRecentTabs();
  }

  final GetAllTabsUsecase getAllTabsUsecase;
  final GetTabCommentsUsecase getTabCommentsUsecase;
  final GetTabUsecase getTabUsecase;

  List<TabEntity> relevantTabsList = [];
  List<TabEntity> recentTabsList = [];
  List<TabEntity> tabComments = [];

  bool isInRelevantPage = true;
  late TabEntity pressedTab;

  Future<void> getRelevantTabs() async {
    emit(TabsLoading());

    final tabList = await getAllTabsUsecase(
        const GetAllTabsParams(page: 1, perPage: 30, strategy: 'relevant'));
    if (relevantTabsList.isEmpty) {
      tabList.forEach((tabList) {
        relevantTabsList.addAll(tabList);
      });
    }
    tabList.fold((l) => emit(TabsError(l)), (r) => emit(TabsLoaded(r)));
  }

  Future<void> getRecentTabs() async {
    emit(TabsLoading());

    final results = await getAllTabsUsecase(
        const GetAllTabsParams(page: 1, perPage: 30, strategy: 'new'));
    if (recentTabsList.isEmpty) {
      results.forEach((tabList) {
        recentTabsList.addAll(tabList);
      });
    }
    results.fold((l) => emit(TabsError(l)), (r) => emit(TabsLoaded(r)));
  }

  Future<void> getTab({required int index}) async {
    emit(TabsLoading());
    if (isInRelevantPage == true) {
      final result = await getTabUsecase(GetTabParams(
          ownerUsername: relevantTabsList[index].ownerUsername,
          slug: relevantTabsList[index].slug));
      result.fold((l) => emit(TabsError(l)), (r) {
        emit(TabLoaded(r));
        pressedTab = r;
      });
    } else {
      final result = await getTabUsecase(GetTabParams(
          ownerUsername: recentTabsList[index].ownerUsername,
          slug: recentTabsList[index].slug));
      result.fold((l) => emit(TabsError(l)), (r) {
        emit(TabLoaded(r));
        pressedTab = r;
      });
    }
  }

  Future<void> getTabComments() async {
    emit(TabsLoading());
    tabComments = [];
    final results = await getTabCommentsUsecase(GetTabCommentsParams(
        ownerUsername: pressedTab.ownerUsername, slug: pressedTab.slug));
    results.forEach((comments) {
      tabComments.addAll(comments);
    });
  }
}

// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';

import 'package:tabnews_app/app/features/tabs/domain/entities/user_entity.dart';
import 'package:tabnews_app/app/features/tabs/domain/usecases/get_user_usecase.dart';
import 'package:tabnews_app/app/features/tabs/domain/entities/tab_entity.dart';
import 'package:tabnews_app/app/features/tabs/domain/usecases/get_all_tabs_usecase.dart';
import 'package:tabnews_app/app/features/tabs/domain/usecases/get_tab_comments_usecase.dart';
import 'package:tabnews_app/app/features/tabs/domain/usecases/get_tab_usecase.dart';

part 'tabs_state.dart';

class TabsCubit extends Cubit<TabsState> {
  TabsCubit(
    this.getAllTabsUsecase,
    this.getTabCommentsUsecase,
    this.getTabUsecase,
    this.getUserUsecase,
  ) : super(TabsInitial());

  final GetAllTabsUsecase getAllTabsUsecase;
  final GetTabCommentsUsecase getTabCommentsUsecase;
  final GetTabUsecase getTabUsecase;
  final GetUserUsecase getUserUsecase;

  List<TabEntity> relevantTabsList = [];
  List<TabEntity> recentTabsList = [];
  List<TabEntity> tabComments = [];
  List<TabEntity> commentsOfTabComments = [];
  int? relevantPage = 1;
  int? recentPage = 1;

  bool isInRelevantPage = false;
  TabEntity? pressedTab;
  UserEntity? userEntity;
  int? userTabCoins;
  int? userTabCash;
  String? userUsername;

  bool toggleIsInRelevantPage(bool value) => isInRelevantPage = value;

  HawkFabMenuController hawkFabMenuController = HawkFabMenuController();

  int loadNextPage(int? page) => page! + 1;

  Future<void> loadMoreTabs() async {
    if (isInRelevantPage == true) {
      relevantPage = loadNextPage(relevantPage);
      final tabList = await getAllTabsUsecase(GetAllTabsParams(
          page: relevantPage!, perPage: 30, strategy: 'relevant'));
      tabList.forEach((tabList) {
        relevantTabsList.addAll(tabList);
      });
      tabList.fold((l) => emit(TabsError()), (r) => emit(TabsLoaded()));
      emit(TabsLoaded());
    } else {
      recentPage = loadNextPage(recentPage);
      final tabList = await getAllTabsUsecase(
          GetAllTabsParams(page: recentPage!, perPage: 30, strategy: 'new'));
      tabList.forEach((tabList) {
        recentTabsList.addAll(tabList);
      });
      tabList.fold((l) => emit(TabsError()), (r) => emit(TabsLoaded()));
      emit(TabsLoaded());
    }
  }

  Future<void> getAllTabs() async {
    List<TabEntity> tabsList = [];

    emit(TabsLoading());

    final results = await getAllTabsUsecase(GetAllTabsParams(
        page: relevantPage!,
        perPage: 30,
        strategy: isInRelevantPage ? 'relevant' : 'new'));
    if (isInRelevantPage) {
      tabsList = relevantTabsList;
    } else {
      tabsList = recentTabsList;
    }
    if (tabsList.isEmpty) {
      results.forEach((tabList) {
        tabsList.addAll(tabList);
      });
    }
    results.fold((l) => emit(TabsError()), (r) => emit(TabsLoaded()));
  }

  Future<void> getTab({required int index}) async {
    emit(TabsLoading());
    if (isInRelevantPage == true) {
      final result = await getTabUsecase(GetTabParams(
          ownerUsername: relevantTabsList[index].ownerUsername,
          slug: relevantTabsList[index].slug));
      result.fold((l) => emit(TabsError()), (r) {
        emit(TabLoaded());
        pressedTab = r;
      });
    } else {
      final result = await getTabUsecase(GetTabParams(
          ownerUsername: recentTabsList[index].ownerUsername,
          slug: recentTabsList[index].slug));
      result.fold(
        (l) => emit(TabsError()),
        (r) {
          emit(TabLoaded());
          pressedTab = r;
        },
      );
    }
  }

  Future<void> getTabComments() async {
    emit(TabsLoading());
    tabComments = [];
    final results = await getTabCommentsUsecase(GetTabCommentsParams(
        ownerUsername: pressedTab!.ownerUsername, slug: pressedTab!.slug));
    results.forEach((comments) {
      tabComments.addAll(comments);
    });
  }

  Future<void> getUser(String token) async {
    emit(TabsLoading());
    final result = await getUserUsecase(UserParams(token));
    result.fold((l) => emit(TabsError()), (r) async {
      userEntity = r;
      userTabCoins = userEntity!.tabcoins;
      userTabCash = userEntity!.tabcash;
      userUsername = userEntity!.username;
    });
  }
}

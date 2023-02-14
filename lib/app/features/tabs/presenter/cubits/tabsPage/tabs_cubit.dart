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

  List<TabEntity> tabsList = [];
  List<TabEntity> tabComments = [];
  List<TabEntity> commentsOfTabComments = [];
  int? relevantPage = 1;
  int? recentPage = 1;
  int page = 1;

  bool isInRelevantPage = false;
  TabEntity? pressedTab;
  UserEntity? userEntity;

  bool toggleIsInRelevantPage(bool value) => isInRelevantPage = value;

  HawkFabMenuController hawkFabMenuController = HawkFabMenuController();

  Future<void> loadMoreTabs() async {
    page += 1;
    final results = await getAllTabsUsecase(GetAllTabsParams(
      page: page,
      perPage: 30,
      strategy: isInRelevantPage ? 'relevant' : 'new',
    ));
    results.forEach((tabList) {
      tabsList.addAll(tabList);
    });
    results.fold((l) => emit(TabsError()), (r) => emit(TabsLoaded()));
  }

  Future<void> getAllTabs() async {
    emit(TabsLoading());
    tabsList.clear();
    final results = await getAllTabsUsecase(GetAllTabsParams(
      page: relevantPage!,
      perPage: 30,
      strategy: isInRelevantPage ? 'relevant' : 'new',
    ));
    results.forEach((tabList) {
      tabsList.addAll(tabList);
    });
    results.fold((l) => emit(TabsError()), (r) => emit(TabsLoaded()));
  }

  Future<void> getTab({required int index}) async {
    emit(TabsLoading());
    final result = await getTabUsecase(GetTabParams(
        ownerUsername: tabsList[index].ownerUsername,
        slug: tabsList[index].slug));
    result.fold((l) => emit(TabsError()), (r) {
      emit(TabLoaded());
      pressedTab = r;
    });
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
    result.fold((l) => emit(TabsError()), (r) {
      userEntity = r;
    });
  }
}

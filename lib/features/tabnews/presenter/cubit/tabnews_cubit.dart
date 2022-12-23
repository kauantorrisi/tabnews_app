// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:tabnews_app/features/tabnews/domain/entities/tab_entity.dart';
import 'package:tabnews_app/features/tabnews/domain/usecases/get_all_tabs_usecase.dart';

part 'tabnews_state.dart';

class TabnewsCubit extends Cubit<TabnewsState> {
  final GetAllTabsUsecase getAllTabsUsecase;

  TabnewsCubit(this.getAllTabsUsecase) : super(TabnewsInitial());

  List<TabEntity> revelantTabsList = [];
  List<TabEntity> recentTabsList = [];
  bool isInRevelantPage = true;

  Future<void> getRevelantTabs() async {
    emit(TabNewsLoading());
    final results = await getAllTabsUsecase(
        const Params(page: 1, perPage: 30, strategy: 'relevant'));
    if (revelantTabsList.isEmpty) {
      results.forEach((tabList) {
        revelantTabsList.addAll(tabList);
      });
    }
    results.fold((l) => emit(TabNewsError()), (r) => emit(TabNewsSuccessful()));
  }

  Future<void> getRecentTabs() async {
    emit(TabNewsLoading());
    final results = await getAllTabsUsecase(
        const Params(page: 1, perPage: 30, strategy: 'new'));
    if (recentTabsList.isEmpty) {
      results.forEach((tabList) {
        recentTabsList.addAll(tabList);
      });
    }
    results.fold((l) => emit(TabNewsError()), (r) => emit(TabNewsSuccessful()));
  }
}

// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:tabnews_app/features/tabnews/domain/entities/tab_entity.dart';
import 'package:tabnews_app/features/tabnews/domain/usecases/get_all_tabs_usecase.dart';

part 'tabnews_state.dart';

class TabnewsCubit extends Cubit<TabnewsState> {
  final GetAllTabsUsecase usecase;

  TabnewsCubit(this.usecase) : super(TabnewsInitial());

  List<TabEntity> tabsList = [];

  Future<void> getRevelantTabs() async {
    emit(TabNewsLoading());
    final results =
        await usecase(const Params(page: 1, perPage: 30, strategy: 'relevant'));
    results.forEach((tabList) {
      tabsList.addAll(tabList);
    });
    results.fold((l) => emit(TabNewsError()), (r) => emit(TabNewsSuccessful()));
  }
}

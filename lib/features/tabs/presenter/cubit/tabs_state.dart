part of 'tabs_cubit.dart';

abstract class TabsState extends Equatable {}

class TabsInitial extends TabsState {
  @override
  List<Object?> get props => [];
}

class TabsLoaded extends TabsState {
  TabsLoaded(this.tabList);

  final List<TabEntity> tabList;

  @override
  List<Object?> get props => [tabList];
}

class TabsError extends TabsState {
  TabsError(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

class TabsLoading extends TabsState {
  @override
  List<Object?> get props => [];
}

class TabLoaded extends TabsState {
  TabLoaded(this.tab);

  final TabEntity tab;

  @override
  List<Object?> get props => [tab];
}

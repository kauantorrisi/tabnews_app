part of 'tabs_cubit.dart';

abstract class TabsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TabsInitial extends TabsState {}

class TabsError extends TabsState {}

class TabsLoading extends TabsState {}

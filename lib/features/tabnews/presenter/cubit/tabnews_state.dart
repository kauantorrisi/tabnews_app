part of 'tabnews_cubit.dart';

abstract class TabnewsState extends Equatable {
  const TabnewsState();

  @override
  List<Object> get props => [];
}

class TabnewsInitial extends TabnewsState {}

class TabNewsSuccessful extends TabnewsState {}

class TabNewsError extends TabnewsState {}

class TabNewsLoading extends TabnewsState {}

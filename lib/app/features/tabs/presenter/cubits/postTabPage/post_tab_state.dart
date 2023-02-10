part of 'post_tab_cubit.dart';

abstract class PostTabState extends Equatable {
  const PostTabState();

  @override
  List<Object> get props => [];
}

class PostTabInitial extends PostTabState {}

class PostTabLoading extends PostTabState {}

class PostTabError extends PostTabState {}

class PostTabSuccessful extends PostTabState {}

part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();
  
  @override
  List<Object> get props => [];
}

class PostsInitialState extends PostsState {}
class PostsLoadingState extends PostsState {}
class PostsLoadedState extends PostsState {
  final List<Post> posts;
  const PostsLoadedState({required this.posts});
  
  @override
  List<Object> get props => [posts];
}
class PostsErrorState extends PostsState {
  final String message;
  const PostsErrorState({required this.message});
  
  @override
  List<Object> get props => [message];
}
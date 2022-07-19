import 'package:bloc/bloc.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/strings/strings.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/usecases/get_all_posts.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostUsecase getAllPost;
  PostsBloc({required this.getAllPost}) : super(PostsInitialState()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent || event is RefreshPostsEvent) {
        emit(PostsLoadingState());
        final failureOrPosts = await getAllPost();
        emit(_mapFailureToState(failureOrPosts));
      }
    });
  }
  
  PostsState _mapFailureToState(Either<Failure, List<Post>> either) {
    return either.fold(
      (failure) => PostsErrorState(message: _mapFailureToMessage(failure)),
      (posts) => PostsLoadedState(posts: posts),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case EmptyCacheFailure:
        return emptyCacheFailureMessage;
      case OfflineFailure:
        return offlineFailureMessage;
      default:
        return 'Unexpected Error, Please Try Again';
    }
  }
}

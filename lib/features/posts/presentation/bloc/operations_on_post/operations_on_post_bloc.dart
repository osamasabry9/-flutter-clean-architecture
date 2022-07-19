import 'package:bloc/bloc.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/strings/strings.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/usecases/create_post.dart';
import '../../../domain/usecases/delete_post.dart';
import '../../../domain/usecases/update_post.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'operations_on_post_event.dart';
part 'operations_on_post_state.dart';

class OperationsOnPostBloc
    extends Bloc<OperationsOnPostEvent, OperationsOnPostState> {
  final CreatePostUsecase createPost;
  final DeletePostUsecase deletePost;
  final UpdatePostUsecase updatePost;

  OperationsOnPostBloc({
    required this.createPost,
    required this.deletePost,
    required this.updatePost,
  }) : super(OperationsOnPostInitialState()) {
    on<OperationsOnPostEvent>((event, emit) async {
      if (event is CreatePostEvent) {
        emit(LoadingOperationsOnPostState());
        final result = await createPost(event.post);
        emit(_mapFailureToState(result, createSuccessMessage));
      } else if (event is UpdatePostEvent) {
        emit(LoadingOperationsOnPostState());
        final result = await updatePost(event.post);
        emit(_mapFailureToState(result, updateSuccessMessage));
      } else if (event is DeletePostEvent) {
        emit(LoadingOperationsOnPostState());
        final result = await deletePost(event.postId);
        emit(_mapFailureToState(result, deleteSuccessMessage));
      }
    });
  }

  OperationsOnPostState _mapFailureToState(
      Either<Failure, Unit> result, String message) {
    return result.fold(
      (failure) =>
          ErrorOperationsOnPostState(message: _mapFailureToMessage(failure)),
      (_) => MessageOperationsOnPostState(message: message),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case OfflineFailure:
        return offlineFailureMessage;
      default:
        return 'Unexpected Error, Please Try Again';
    }
  }
}

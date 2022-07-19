part of 'operations_on_post_bloc.dart';

abstract class OperationsOnPostEvent extends Equatable {
  const OperationsOnPostEvent();

  @override
  List<Object> get props => [];
}

class CreatePostEvent extends OperationsOnPostEvent {
  final Post post;

  const CreatePostEvent({required this.post});

  @override
  List<Object> get props => [post];
}

class UpdatePostEvent extends OperationsOnPostEvent {
  final Post post;

  const UpdatePostEvent({required this.post});

  @override
  List<Object> get props => [post];
}

class DeletePostEvent extends OperationsOnPostEvent {
  final int postId;

  const DeletePostEvent({required this.postId});

  @override
  List<Object> get props => [postId];
}
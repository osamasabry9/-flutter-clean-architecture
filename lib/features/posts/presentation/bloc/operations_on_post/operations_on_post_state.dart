part of 'operations_on_post_bloc.dart';

abstract class OperationsOnPostState extends Equatable {
  const OperationsOnPostState();

  @override
  List<Object> get props => [];
}

class OperationsOnPostInitialState extends OperationsOnPostState {}

class LoadingOperationsOnPostState extends OperationsOnPostState {}

class MessageOperationsOnPostState extends OperationsOnPostState {
  final String message;

  const MessageOperationsOnPostState({required this.message});

  @override
  List<Object> get props => [message];
}

class ErrorOperationsOnPostState extends OperationsOnPostState {
  final String message;

  const ErrorOperationsOnPostState({required this.message});

  @override
  List<Object> get props => [message];
}

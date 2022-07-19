import '../../../../core/error/failure.dart';
import '../entities/post.dart';
import 'package:dartz/dartz.dart';

abstract class PostsRepositories {
  Future<Either<Failure , List<Post>>> getAllPosts();
  Future<Either<Failure , Unit>> createPost(Post post);
  Future<Either<Failure , Unit>>  updatePost(Post post);
  Future<Either<Failure , Unit>>  deletePost(int id);
}

// either is a type that can be either right or left.
// unit is a type that represents a void function.

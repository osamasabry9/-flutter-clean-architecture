import '../../../../core/error/failure.dart';
import '../repositories/posts_repositories.dart';
import 'package:dartz/dartz.dart';

class DeletePostUsecase {
  final PostsRepositories postRepository;

  DeletePostUsecase({required this.postRepository});

  Future<Either<Failure, Unit>> call(int postId) async {
    return await postRepository.deletePost(postId);
  }
}
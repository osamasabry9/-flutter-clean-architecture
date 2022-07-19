import '../../../../core/error/failure.dart';
import '../entities/post.dart';
import '../repositories/posts_repositories.dart';
import 'package:dartz/dartz.dart';

class UpdatePostUsecase {
  final PostsRepositories postRepository;

  UpdatePostUsecase({required this.postRepository});

  Future<Either<Failure, Unit>> call(Post post) async {
    return await postRepository.updatePost(post);
  }
}
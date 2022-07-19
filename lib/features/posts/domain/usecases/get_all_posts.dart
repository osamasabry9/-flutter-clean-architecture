import '../entities/post.dart';
import '../../../../core/error/failure.dart';
import '../repositories/posts_repositories.dart';
import 'package:dartz/dartz.dart';

class GetAllPostUsecase {
  final PostsRepositories postRepository;

  GetAllPostUsecase({required this.postRepository});

  Future<Either<Failure, List<Post>>> call() async {
    return await postRepository.getAllPosts();
  }
}
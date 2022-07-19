import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/post_local_data_source.dart';
import '../datasources/post_remote_data_source.dart';
import '../models/post_model.dart';
import '../../domain/entities/post.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repositories/posts_repositories.dart';
import 'package:dartz/dartz.dart';

typedef Future<Unit> returnTypes();

class PostRepositoryImpl implements PostsRepositories {
  final PostLocalDataSource localDataSource;
  final PostRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PostRepositoryImpl(
      {required this.localDataSource,
      required this.remoteDataSource,
      required this.networkInfo});
  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllPosts();
        localDataSource.cachePost(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> createPost(Post post) async {
    final PostModel postModel = PostModel(
      title: post.title,
      body: post.body,
    );
    return await _getMessage(() => remoteDataSource.createPost(postModel));
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    return await _getMessage(() => remoteDataSource.deletePost(postId));
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final PostModel postModel = PostModel(
      id: post.id!,
      title: post.title,
      body: post.body,
    );
    return await _getMessage(() => remoteDataSource.updatePost(postModel));
  }

  Future<Either<Failure, Unit>> _getMessage(
    returnTypes operation,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        await operation();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}

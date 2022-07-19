import 'features/posts/domain/repositories/posts_repositories.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/posts/data/datasources/post_local_data_source.dart';
import 'features/posts/data/datasources/post_remote_data_source.dart';
import 'features/posts/data/repositories/post_repositories_impl.dart';
import 'features/posts/domain/usecases/create_post.dart';
import 'features/posts/domain/usecases/delete_post.dart';
import 'features/posts/domain/usecases/get_all_posts.dart';
import 'features/posts/domain/usecases/update_post.dart';
import 'features/posts/presentation/bloc/operations_on_post/operations_on_post_bloc.dart';
import 'features/posts/presentation/bloc/posts/posts_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! BLOCS
  sl.registerFactory(() => PostsBloc(
        getAllPost: sl(),
      ));
  sl.registerFactory(() => OperationsOnPostBloc(
        createPost: sl(),
        deletePost: sl(),
        updatePost: sl(),
      ));
  //! USECASES
  sl.registerLazySingleton(() => GetAllPostUsecase(
        postRepository: sl(),
      ));
  sl.registerLazySingleton(() => CreatePostUsecase(
        postRepository: sl(),
      ));
  sl.registerLazySingleton(() => DeletePostUsecase(
        postRepository: sl(),
      ));
  sl.registerLazySingleton(() => UpdatePostUsecase(
        postRepository: sl(),
      ));
  //! REPOSITORIES
  sl.registerLazySingleton<PostsRepositories>(() => PostRepositoryImpl(
        localDataSource: sl(),
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));
  //! DATA SOURCES
  sl.registerLazySingleton<PostLocalDataSource>(() => PostLocalDataSourceImpl(
        sharedPreferences: sl(),
      ));
  sl.registerLazySingleton<PostRemoteDataSource>(() => PostRemoteDataSourceImpl(
        client: sl(),
      ));
  //! NETWORK INFO
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(
        connectionChecker: sl(),
      ));
  //! CONNECTION CHECKER
  sl.registerLazySingleton(() => InternetConnectionChecker());
  //! CLIENT
  sl.registerLazySingleton(() => http.Client());
  //! SHARED PREFERENCES
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}

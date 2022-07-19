import 'core/util/app_themes.dart';
import 'features/posts/presentation/pages/posts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/posts/presentation/bloc/operations_on_post/operations_on_post_bloc.dart';
import 'features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<PostsBloc>()..add(GetAllPostsEvent())),
        BlocProvider(create: (context) => di.sl<OperationsOnPostBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: appTheme,
        home: const PostsPage(),
      ),
    );
  }
}

import '../../../../core/widgets/loading_widget.dart';
import '../bloc/posts/posts_bloc.dart';
import 'post_create_update_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/post_page/message_display_widget.dart';
import '../widgets/post_page/posts_list_widget.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Posts'),
      centerTitle: true,
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is PostsLoadingState) {
            return const LoadingWidget();
          } else if (state is PostsLoadedState) {
            return RefreshIndicator(
              onRefresh: () => _onRefresh(context),
              child: PostListWidget(
                posts: state.posts,
              ),
            );
          } else if (state is PostsErrorState) {
            return MessageDisplayWidget(message: state.message);
          }
          return const LoadingWidget();
        },
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
  }

  FloatingActionButton _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    const PostCreateUpdatePage(isUpdatePost: false)));
      },
    );
  }
}

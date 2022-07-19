import '../../../../core/util/snack_bar.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../domain/entities/post.dart';
import '../bloc/operations_on_post/operations_on_post_bloc.dart';
import 'posts_page.dart';
import '../widgets/post_create_update/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostCreateUpdatePage extends StatelessWidget {
  final Post? post;
  final bool isUpdatePost;
  const PostCreateUpdatePage({
    Key? key,
    this.post,
    required this.isUpdatePost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(title: Text(isUpdatePost ? "Edit Post" : "Add Post"));
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocConsumer<OperationsOnPostBloc, OperationsOnPostState>(
          listener: (context, state) {
            if(state is MessageOperationsOnPostState)
            {
              SnackBarMessage().showSuccessSnackBar(
                    message: state.message, context: context);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const PostsPage()),
                    (route) => false);
            }else if (state is ErrorOperationsOnPostState) {
              SnackBarMessage().showErrorSnackBar(
                    message: state.message, context: context);
            }
          },
          builder: (context, state) {
            if (state is LoadingOperationsOnPostState) {
              return const LoadingWidget();
            }
            return FormWidget(
                  isUpdatePost: isUpdatePost, post: isUpdatePost ? post : null);
          },
        ),
      ),
    );
  }
}

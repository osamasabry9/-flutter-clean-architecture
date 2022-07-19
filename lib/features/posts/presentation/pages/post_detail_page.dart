import '../../domain/entities/post.dart';
import '../widgets/post_detail/post_detail_widget.dart';
import 'package:flutter/material.dart';

class PostDetailPage extends StatelessWidget {
  final Post post;
  const PostDetailPage({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Post Detail'),
      centerTitle: true,
    );
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: PostDetailWidget(post: post),
      ),
    );
  }
}

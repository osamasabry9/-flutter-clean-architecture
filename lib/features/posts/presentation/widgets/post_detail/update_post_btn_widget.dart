import '../../pages/post_create_update_page.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/post.dart';

class UpdatePostBtnWidget extends StatelessWidget {
  final Post post;
  const UpdatePostBtnWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PostCreateUpdatePage(
                isUpdatePost: true,
                post: post,
              ),
            ));
      },
      icon: const Icon(Icons.edit),
      label: const Text("Edit"),
    );
  }
}
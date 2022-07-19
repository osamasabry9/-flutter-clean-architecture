import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exception.dart';
import '../../../../core/strings/strings.dart';
import '../models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> deletePost(int postId);
  Future<Unit> createPost(PostModel post);
  Future<Unit> updatePost(PostModel post);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final http.Client client;
  PostRemoteDataSourceImpl({required this.client});
  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(
      Uri.parse(baseUrl + '/posts/'),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body) as List;
      final List<PostModel> postsModels =
          decodedJson.map((json) => PostModel.fromJson(json)).toList();
      return postsModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> createPost(PostModel post) async {
    final body = {
      'title': post.title,
      'body': post.body,
    };
    final response = await client.post(
      Uri.parse(baseUrl + '/posts/'),
      body: body,
    );
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final response = await client.delete(
      Uri.parse(baseUrl + '/posts/${postId.toString()}'),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel post) async {
    final postId = post.id.toString();
    final body = {
      'title': post.title,
      'body': post.body,
    };
    final response = await client.patch(
      Uri.parse(baseUrl + '/posts/$postId'),
      body: body,
    );
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}

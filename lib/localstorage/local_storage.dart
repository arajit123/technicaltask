import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:technicaltask/models/models.dart';

Future<void> savePostsToLocal(List<Post> posts) async {
  final prefs = await SharedPreferences.getInstance();
  List<String> postsList = posts.map((post) => json.encode({
    'id': post.id,
    'title': post.title,
    'body': post.body,
    'isRead': post.isRead,
    'timerDuration': post.timerDuration,
  })).toList();
  await prefs.setStringList('posts', postsList);
}

Future<List<Post>> loadPostsFromLocal() async {
  final prefs = await SharedPreferences.getInstance();
  List<String> postsList = prefs.getStringList('posts') ?? [];
  return postsList.map((postJson) {
    final data = json.decode(postJson);
    return Post(
      id: data['id'],
      title: data['title'],
      body: data['body'],
      isRead: data['isRead'],
      timerDuration: data['timerDuration'],
    );
  }).toList();
}

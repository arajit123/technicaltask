import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technicaltask/models/models.dart';

class PostProvider with ChangeNotifier {
  List<Post> _posts = [];
  bool _isLoading = false;

  List<Post> get posts => _posts;
  bool get isLoading => _isLoading;
  
  

  Future<void> fetchPosts() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        _posts = jsonResponse.map((post) => Post.fromJson(post)).toList();
        await _savePostsToLocal(_posts);
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (error) {
      print(error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _savePostsToLocal(List<Post> posts) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> encodedPosts = posts.map((post) => json.encode(post.toJson())).toList();
    await prefs.setStringList('posts', encodedPosts);
  }

  Future<void> loadPostsFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? encodedPosts = prefs.getStringList('posts');
    if (encodedPosts != null) {
      _posts = encodedPosts.map((e) => Post.fromJson(json.decode(e))).toList();
    }
    notifyListeners();
  }

  void markAsRead(int postId) {
    final post = _posts.firstWhere((post) => post.id == postId);
    post.isRead = true;
    notifyListeners();
  }

  void startTimer(Post post) {
    if (post.timerStart == null) {
      post.timerStart = DateTime.now();
    }

    post.timerPaused = false;
    post.timerTicker = Ticker((elapsed) {
      if (!post.timerPaused) {
        post.timerDuration = elapsed.inSeconds;
        notifyListeners();
      }
    });
    post.timerTicker!.start();
  }

  void pauseTimer(Post post) {
    post.timerPaused = true;
    post.timerTicker?.stop();
    notifyListeners();
  }
}

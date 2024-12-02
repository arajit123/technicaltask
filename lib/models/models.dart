import 'package:flutter/scheduler.dart'; // For Ticker

class Post {
  final int id;
  final String title;
  String body;
  bool isRead;
  int timerDuration;
  bool timerPaused;
  DateTime? timerStart;
  Ticker? timerTicker;

  Post({
    required this.id,
    required this.title,
    required this.body,
    this.isRead = false,
    this.timerDuration = 0,
    this.timerPaused = true,
    this.timerStart,
    this.timerTicker,
  });

  // Create a Post object from JSON
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      isRead: json['isRead'] ?? false,
      timerDuration: json['timerDuration'] ?? 0,
      timerPaused: json['timerPaused'] ?? true,
    );
  }

  // Convert a Post object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'isRead': isRead,
      'timerDuration': timerDuration,
      'timerPaused': timerPaused,
    };
  }
}

import 'package:flutter/material.dart';
import 'package:technicaltask/models/models.dart';

class PostDetailScreen extends StatelessWidget {
  final Post post;

  PostDetailScreen({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          backgroundColor: Colors.pink,
          centerTitle: true,
          title: Text(
            'Post Details',
            style: TextStyle(color: Colors.white),
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),textAlign: TextAlign.justify,),
            SizedBox(height: 20),
            Text(post.body,style: TextStyle(),textAlign: TextAlign.justify,),
          ],
        ),
      ),
    );
  }
}

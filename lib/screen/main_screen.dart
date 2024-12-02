import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technicaltask/provider/time_management.dart';
import 'package:technicaltask/screen/post_details_screen.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PostListScreen extends StatefulWidget {
  @override
  _PostListScreenState createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  @override
  void initState() {
    super.initState();
    _initializePosts();
  }

  Future<void> _initializePosts() async {
    try {
      final postProvider = Provider.of<PostProvider>(context, listen: false);
      await postProvider.loadPostsFromLocal();
      await postProvider.fetchPosts();
    } catch (e) {
      // Display an error to the user
      print('Error initializing posts: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context);
    final posts = postProvider.posts;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text('Posts', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: postProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : posts.isEmpty
              ? Center(child: Text("No posts available"))
              : ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return VisibilityDetector(
                      key: Key(post.id.toString()),
                      onVisibilityChanged: (visibilityInfo) {
                        if (visibilityInfo.visibleFraction > 0) {
                          if (post.timerTicker == null || post.timerPaused) {
                            postProvider.startTimer(post);
                          }
                        } else {
                          postProvider.pauseTimer(post);
                        }
                      },
                      child: GestureDetector(
                        onTap: () {
                          postProvider.markAsRead(post.id);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PostDetailScreen(post: post),
                            ),
                          ).then((_) {
                            if (post.timerPaused) {
                              postProvider.startTimer(post);
                            }
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 650,
                            decoration: BoxDecoration(
                              color: post.isRead ? Colors.white : Colors.yellow[100],
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 5,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('${post.timerDuration}s'),
                                    Icon(Icons.timer, color: Colors.pink),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Center(
                                  child: Text(
                                    post.title,
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}

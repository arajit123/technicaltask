import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technicaltask/provider/time_management.dart';

import 'package:technicaltask/screen/main_screen.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => PostProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PostListScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:blog_app/screens/home_screen.dart';
import 'package:blog_app/screens/add_edit_screen.dart';
import 'package:blog_app/screens/view_screen.dart';
import 'package:blog_app/models/blog_item.dart';

class BlogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Offline Blog App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
      onGenerateRoute: _generateRoute,
    );
  }

  Route<dynamic>? _generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/addEdit':
        final BlogItem? blogItem = settings.arguments as BlogItem?;
        return MaterialPageRoute(
          builder: (context) => AddEditScreen(blogItem: blogItem),
        );
      case '/view':
        final BlogItem blogItem = settings.arguments as BlogItem;
        return MaterialPageRoute(
          builder: (context) => ViewScreen(blogItem: blogItem),
        );
      default:
        return null;
    }
  }
}

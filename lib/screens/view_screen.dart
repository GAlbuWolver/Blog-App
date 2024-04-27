import 'package:blog_app/screens/add_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:blog_app/models/blog_item.dart';
import 'package:blog_app/services/db_helper.dart';
import 'dart:io';

class ViewScreen extends StatelessWidget {
  final BlogItem blogItem;

  ViewScreen({required this.blogItem});

  void _deleteBlogItem(BuildContext context, int id) async {
    await DBHelper.deleteBlogItem(id);
    Navigator.pop(context);  // Go back after deletion
  }

  void _editBlogItem(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditScreen(blogItem: blogItem),
      ),
    ).then((value) {
      Navigator.pop(context);  // Go back after editing
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(blogItem.title),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => _editBlogItem(context),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _deleteBlogItem(context, blogItem.id!),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (blogItem.imagePath != null && blogItem.imagePath!.isNotEmpty)
              Image.file(File(blogItem.imagePath!), fit: BoxFit.cover),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    blogItem.date.toIso8601String(),
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 8),
                  Text(
                    blogItem.body,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

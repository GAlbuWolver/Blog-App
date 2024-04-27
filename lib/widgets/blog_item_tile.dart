import 'dart:io';

import 'package:flutter/material.dart';
import 'package:blog_app/models/blog_item.dart';

class BlogItemTile extends StatelessWidget {
  final BlogItem blogItem;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const BlogItemTile({Key? key, required this.blogItem, this.onTap, this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: blogItem.imagePath != null && blogItem.imagePath!.isNotEmpty
          ? Image.file(File(blogItem.imagePath!), width: 50, height: 50, fit: BoxFit.cover)
          : const Icon(Icons.image, size: 50),  // Default icon if no image is available
      title: Text(blogItem.title),
      subtitle: Text(
        "${blogItem.date.toIso8601String()} - ${blogItem.body}",
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: onTap,
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: onDelete,
      ),
      isThreeLine: true,
    );
  }
}

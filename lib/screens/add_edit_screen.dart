import 'dart:io';

import 'package:flutter/material.dart';
import 'package:blog_app/models/blog_item.dart';
import 'package:blog_app/services/db_helper.dart';
import 'package:blog_app/services/image_service.dart';

class AddEditScreen extends StatefulWidget {
  final BlogItem? blogItem;

  const AddEditScreen({Key? key, this.blogItem}) : super(key: key);

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _bodyController;
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.blogItem?.title ?? '');
    _bodyController = TextEditingController(text: widget.blogItem?.body ?? '');
    _imagePath = widget.blogItem?.imagePath;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImageService imageService = ImageService();
    final String? imagePath = await imageService.pickImageFromGallery();
    setState(() {
      _imagePath = imagePath;
    });
  }

  void _saveBlogItem() {
    if (_formKey.currentState!.validate()) {
      final BlogItem newItem = BlogItem(
        title: _titleController.text,
        date: DateTime.now(),
        body: _bodyController.text,
        imagePath: _imagePath,
      );
      if (widget.blogItem == null) {
        DBHelper.addBlogItem(newItem);
      } else {
        DBHelper.updateBlogItem(newItem);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.blogItem == null ? 'Add Blog Item' : 'Edit Blog Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _bodyController,
                decoration: InputDecoration(labelText: 'Body'),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              _imagePath != null
                  ? Image.file(File(_imagePath!))
                  : Container(height: 200, color: Colors.grey[300], child: Icon(Icons.image, size: 100)),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick Image'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveBlogItem,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

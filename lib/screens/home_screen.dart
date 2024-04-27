import 'package:blog_app/screens/add_edit_screen.dart';
import 'package:blog_app/screens/view_screen.dart';
import 'package:flutter/material.dart';
import 'package:blog_app/models/blog_item.dart';
import 'package:blog_app/services/db_helper.dart';
import 'package:blog_app/widgets/blog_item_tile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<BlogItem>> _blogItems;

  @override
  void initState() {
    super.initState();
    _refreshBlogItems();
  }

  void _refreshBlogItems() {
    setState(() {
      _blogItems = DBHelper.fetchBlogItems();
    });
  }

  void _deleteBlogItem(int id) async {
    await DBHelper.deleteBlogItem(id);
    _refreshBlogItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddEditScreen()),
              ).then((_) => _refreshBlogItems()); // Refresh list after adding/editing
            },
          ),
        ],
      ),
      body: FutureBuilder<List<BlogItem>>(
        future: _blogItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return Center(child: Text('An error occurred!'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (ctx, i) => Dismissible(
                key: ValueKey(snapshot.data![i].id),
                background: Container(color: Colors.red, child: Icon(Icons.delete, color: Colors.white, size: 40), alignment: Alignment.centerRight, padding: EdgeInsets.only(right: 20)),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  _deleteBlogItem(snapshot.data![i].id!);
                },
                child: BlogItemTile(
                  blogItem: snapshot.data![i],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ViewScreen(blogItem: snapshot.data![i])),
                    );
                  },
                ),
              ),
            );
          } else {
            return Center(child: Text('No blog items found'));
          }
        },
      ),
    );
  }
}

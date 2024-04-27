import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:blog_app/models/blog_item.dart';

class DBHelper {
  static Database? _database;

  // Get singleton instance of database
  static Future<Database> get database async {
    if (_database != null) return _database!;
    // Lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  static Future<Database> _initDatabase() async {
    String dbPath = join(await getDatabasesPath(), 'blog.db');
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // SQL code to create the database table
  static Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE BlogItems(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        date TEXT NOT NULL,
        body TEXT NOT NULL,
        imagePath TEXT
      );
    ''');
  }

  // Method to add new BlogItem to the database
  static Future<int> addBlogItem(BlogItem item) async {
    Database db = await database;
    return await db.insert('BlogItems', item.toMap());
  }

  // Method to fetch all blog items
  static Future<List<BlogItem>> fetchBlogItems() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('BlogItems');
    return List.generate(maps.length, (i) {
      return BlogItem.fromMap(maps[i]);
    });
  }

  // Method to update an existing blog item
  static Future<void> updateBlogItem(BlogItem item) async {
    Database db = await database;
    await db.update(
      'BlogItems',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  // Method to delete a blog item
  static Future<void> deleteBlogItem(int id) async {
    Database db = await database;
    await db.delete(
      'BlogItems',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

class BlogItem {
  int? id;
  String title;
  DateTime date;
  String body;
  String? imagePath;

  BlogItem({this.id, required this.title, required this.date, required this.body, this.imagePath});

  // Convert a BlogItem into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),  // Storing the date as a string in ISO-8601 format
      'body': body,
      'imagePath': imagePath,
    };
  }

  // building a BlogItem from each row.
  factory BlogItem.fromMap(Map<String, dynamic> map) {
    return BlogItem(
      id: map['id'],
      title: map['title'],
      date: DateTime.parse(map['date']),
      body: map['body'],
      imagePath: map['imagePath'],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:blog_app/app.dart';

void main() {
  testWidgets('HomeScreen has correct AppBar title and FAB', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(BlogApp());

    // Verify that HomeScreen is showing the correct AppBar title.
    expect(find.text('Blog Home'), findsOneWidget);

    // Verify that a FloatingActionButton is present.
    expect(find.byType(FloatingActionButton), findsOneWidget);

    // Optionally, you can also check for the tooltip of the FloatingActionButton.
    expect(find.byTooltip('Add Blog Item'), findsOneWidget);
  });
}

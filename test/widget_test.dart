import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ai_music_production/main.dart';

void main() {
  testWidgets('AI Music Production app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MusicProductionApp());

    // Verify that the app title is displayed
    expect(find.text('AI Music Production'), findsOneWidget);

    // Verify that the text fields are present
    expect(find.byType(TextField), findsNWidgets(4));

    // Verify that the 'Create/Update Lyrics' button is present
    expect(find.text('Create/Update Lyrics'), findsOneWidget);
  });

  testWidgets('Text fields are editable', (WidgetTester tester) async {
    await tester.pumpWidget(MusicProductionApp());

    // Find the language text field and enter text
    await tester.enterText(find.widgetWithText(TextField, 'Language'), 'English');
    expect(find.text('English'), findsOneWidget);

    // Find the genre text field and enter text
    await tester.enterText(find.widgetWithText(TextField, 'Genre'), 'Rock');
    expect(find.text('Rock'), findsOneWidget);
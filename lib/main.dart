import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MusicProductionApp());
}

class MusicProductionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Music Production',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MusicProductionHome(),
    );
  }
}

class MusicProductionHome extends StatefulWidget {
  @override
  _MusicProductionHomeState createState() => _MusicProductionHomeState();
}

class _MusicProductionHomeState extends State<MusicProductionHome> {
  final TextEditingController _languageController = TextEditingController();
  final TextEditingController _genreController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _lyricsController = TextEditingController();

  Future<void> _generateLyrics() async {
  try {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/generate_lyrics'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'prompt': _descriptionController.text,
        'language': _languageController.text,
        'genre': _genreController.text,
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        _lyricsController.text = jsonDecode(response.body)['lyrics'];
      });
    } else {
      print('Server responded with status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to generate lyrics: ${response.body}');
    }
  } catch (e) {
    print('Error generating lyrics: $e');
    setState(() {
      _lyricsController.text = 'Error: $e';
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Music Production'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _languageController,
              decoration: InputDecoration(labelText: 'Language'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _genreController,
              decoration: InputDecoration(labelText: 'Genre'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(labelText: 'Describe the song you would like to produce'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _generateLyrics,
              child: Text('Create/Update Lyrics'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: TextField(
                controller: _lyricsController,
                maxLines: null,
                readOnly: true,
                decoration: InputDecoration(labelText: 'Generated Lyrics'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
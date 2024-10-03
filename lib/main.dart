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
  bool _isLoading = false;

  Future<void> _generateLyrics() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final apiUrl = Uri.parse('${Uri.base.origin}/api/generate_lyrics');
      final response = await http.post(
        apiUrl,
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
        throw Exception('Failed to generate lyrics: ${response.body}');
      }
    } catch (e) {
      print('Error generating lyrics: $e');
      setState(() {
        _lyricsController.text = '';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error generating lyrics: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
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
              onPressed: _isLoading ? null : _generateLyrics,
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
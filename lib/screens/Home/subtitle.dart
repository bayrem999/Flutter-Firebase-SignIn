import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SubtitleScreen extends StatefulWidget {
  @override
  _SubtitleScreenState createState() => _SubtitleScreenState();
}

class _SubtitleScreenState extends State<SubtitleScreen> {
  final SpeechToText _speechToText = SpeechToText();
  String recognizedText = '';

  Future<void> startListening() async {
    bool isAvailable = await _speechToText.initialize();
    if (isAvailable) {
      _speechToText.listen(
        onResult: (result) {
          setState(() {
            recognizedText = result.recognizedWords;
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Subtitles')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(recognizedText),
            ElevatedButton(
              onPressed: startListening,
              child: Text('Start Listening'),
            ),
          ],
        ),
      ),
    );
  }
}

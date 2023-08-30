import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'AppState.dart';
import 'CustomDrawer.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}





class _VideoPlayerScreenState extends State<VideoPlayerScreen> {

  // Assuming you have a Firestore document with videoUrl and spokenText fields

  Future<Map<String, dynamic>> fetchVideoDataFromFirestore() async {
    // Fetch the Firestore document containing video information
    DocumentSnapshot videoSnapshot = await FirebaseFirestore.instance
        .collection('videos')
        .doc('9voViyUUFWYGd70RIbet')
        .get();

    // Extract the video URL and spoken text
    String videoUrl = videoSnapshot.get('videoUrl');
   // String spokenText = videoSnapshot.get('spokenText');

    return {'videoUrl': videoUrl/*, 'spokenText': spokenText*/};
  }

  late VideoPlayerController _controller;
  bool _isVideoLoaded = false; // Track if the video is loaded

  @override
  void initState() {
    super.initState();
    fetchAndInitializeVideo();
  }

  Future<void> fetchAndInitializeVideo() async {
    // Fetch video URL from Firestore
    Map<String, dynamic> videoData = await fetchVideoDataFromFirestore();

    // Get the video URL from the videoData map
    String videoUrl = videoData['videoUrl'];

    // Initialize the video player
    _controller = VideoPlayerController.network(videoUrl)
      ..initialize().then((_) {
        setState(() {
          _isVideoLoaded = true; // Video is now loaded
        });
      });
  }


  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  void _initSpeech() async {
    _isListening = await _speech.initialize();
    setState(() {});
  }

  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _transcription = '';

  Future<void> startListening() async {
    print("Initializing speech recognition...");
    bool available = await _speech.initialize();
    print("Speech recognition initialized: $available");



    if (available) {
      _speech.listen(
        onResult: (result) {
          if (result.finalResult) {
            setState(() {
              _transcription = result.recognizedWords;
            });
          }
        },

      );

      setState(() {
        _isListening = true;
      });
    } else {
      print("Speech recognition is not available or not initialized.");
    }
  }


  void stopListening () async  {
    _speech.stop();
    setState(() {
      _isListening = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.orangeAccent ,
          title: Text('Video Player')),
      drawer: customDrawer(appState.selectedIndex, selectedPlanet: null,),

      body: Column(
        children: [
          _isVideoLoaded
              ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
              : CircularProgressIndicator(), // Video player
          Divider(),
          _isListening
              ? Text("Listening...")
              : ElevatedButton(
            onPressed: startListening,
            child: Text("Start Listening"),
          ),
          Text(_transcription),
          _isListening
              ? ElevatedButton(
            onPressed: stopListening,
            child: Text("Stop Listening"),
          ): SizedBox(),



        ],
      ),

      floatingActionButton: _isVideoLoaded
          ? FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      )
          : null, // Disable FAB when video is not loaded
    );
  }
}

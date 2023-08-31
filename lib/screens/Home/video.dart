import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../Services/ThemeService.dart';
import '../../constant.dart';
import 'AppState.dart';
import 'CustomDrawer.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sign_in/Models/Font.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}





class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  final themeService _fontx = themeService();
  var text = "";
  bool isTranscribing = false;
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
    String audio = videoSnapshot.get('audio');
print(audio);
    return {'videoUrl': videoUrl, 'audio': audio};
  }

  late VideoPlayerController _controller;
  bool _isVideoLoaded = false; // Track if the video is loaded

  @override
  void initState() {
    super.initState();
    fetchAndInitializeVideo();
  }
Future<String> fethAudio() async {
  Map<String, dynamic> videoData = await fetchVideoDataFromFirestore();
  String audio = videoData["audio"];
    return audio;
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

  Future<String> convertSpeechToText(String filePath) async {
    const apiKey = apiSecretKey;
    var url = Uri.https("api.openai.com", "v1/audio/transcriptions");
    var request = http.MultipartRequest('POST', url);
    request.headers.addAll({"Authorization": "Bearer $apiKey"});
    request.fields["model"] = 'whisper-1';
    request.fields["language"] = "en";

    request.files.add(await http.MultipartFile.fromPath('file', filePath));

    var response = await request.send();
    var newResponse = await http.Response.fromStream(response);

    final responseData = json.decode(newResponse.body);
    return responseData['text'];
     // Placeholder value
  }


  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }









  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.orangeAccent ,
          title: Text( AppLocalizations.of(context)!.videoplayer, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontFamily: _fontx.getFontFamilyFromAppFont(Provider.of<AppState>(context).selectedFont),
              fontSize: Provider.of<AppState>(context).fontSize )) ) ,
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

          Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  if (!isTranscribing) {
                    setState(() {
                      isTranscribing = true;
                    });
                    final result = await FilePicker.platform.pickFiles();
                    if (result != null) {
                      convertSpeechToText(result.files.single.path!)
                          .then((value) {
                        setState(() {
                          text = value;
                          isTranscribing =
                              false; // Transcription is completed or canceled
                        });
                      });
                    } else {
                      setState(() {
                        isTranscribing = false; // Transcription is canceled
                      });
                    }
                  }
                },
                child: Text("Start Transcription"),
              ),
              if (isTranscribing) CircularProgressIndicator(),
              // Display the progress indicator when transcribing
            ],
          ),

          SizedBox(height: 10), // Add some spacing
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  text,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),

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
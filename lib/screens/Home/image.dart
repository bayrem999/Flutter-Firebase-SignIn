import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'AppState.dart';
import 'CustomDrawer.dart';

class ImageWithDescription extends StatefulWidget {
  @override
  _ImageWithDescriptionState createState() => _ImageWithDescriptionState();
}

class _ImageWithDescriptionState extends State<ImageWithDescription> {
  List<Map<String, dynamic>> imagesList = [];

  @override
  void initState() {
    super.initState();
    fetchImages();
  }

  Future<String> getImageUrl(String gsUrl) async {
    Reference ref = FirebaseStorage.instance.refFromURL(gsUrl);
    String downloadUrl = await ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> fetchImages() async {

    try {
      // Fetch image data from Firestore collection
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Images').get();
      List<Map<String, dynamic>> fetchedImagesList = [];

      // Extract image URLs and descriptions from Firestore documents
      snapshot.docs.forEach((doc) {
        fetchedImagesList.add({
          'imageUrl': doc['imageUrl'],
          'description': doc['description'],
        });
      });

      setState(() {
        imagesList = fetchedImagesList;
      });
    } catch (error) {
      print('Error fetching images: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text('Images with Descriptions'),
      ),
      drawer: customDrawer(appState.selectedIndex, selectedPlanet: null,),
      body: imagesList.isEmpty
          ? const Center(
        child:  CircularProgressIndicator(color: Colors.orangeAccent,
          backgroundColor: Colors.blueGrey,),
      )
          :CarouselSlider.builder(
        itemCount: imagesList.length,
        itemBuilder: (context, index, realIndex) {
          final imageUrl = imagesList[index]['imageUrl'];
          final description = imagesList[index]['description'];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Semantics(
              label: description,
              child: Image.network(imageUrl),
            ),
          );
        },
        options: CarouselOptions(
          height: 400, // Adjust the height as needed
          viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
        ),
      ),
    );
  }
}



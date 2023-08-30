import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // Import the package

import '../../Models/User.dart';

class UserDetailsScreen extends StatelessWidget {
  final Users user;

  const UserDetailsScreen({required this.user});

  void _sendEmail(String recipientEmail) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: recipientEmail,
      query: 'subject=Hello from Your App!',
    );
    final emailUri = params; // No need for .toString() here

    if (await canLaunchUrl(emailUri.resolveUri(emailUri))) {
      await launchUrl(emailUri.resolveUri(emailUri));
    } else {
      // Handle the case where the email app cannot be launched
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text('User Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    //backgroundImage: NetworkImage(user.profileImageUrl ?? 'fallback_image_url'),
                    radius: 40,
                  ),
                  SizedBox(height: 16),
                  Text(user.fullName ?? 'No Name', style: TextStyle(fontSize: 20)),
                  SizedBox(height: 8),
                  Text(user.email ?? 'No Email', style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 8),
                  InkWell(
                    onTap: () {
                      if (user.phonenumber != null) {
                        // Call the phone number
                      }
                    },
                    child: Text(
                      user.phonenumber ?? 'No Phone Number',
                      style: TextStyle(
                        color: user.phonenumber != null ? Colors.blue : Colors.grey,
                        decoration: user.phonenumber != null
                            ? TextDecoration.underline
                            : TextDecoration.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.mail),
                    onPressed: () => _sendEmail(user.email!),
                  ),
                  IconButton(
                    icon: Icon(Icons.call),
                    onPressed: () {
                      if (user.phonenumber != null) {
                        launch('tel:${user.phonenumber}');
                        // Call the phone number
                      }
                    },
                  ),
                ],
              ),
            ),
            Divider(),
            // Add the GoogleMap widget here
            Container(
              height: 300, // Set the desired map height
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(user.location!.latitude, user.location!.longitude),
                  zoom: 15.0,
                ),
                markers: {
                  Marker(
                    markerId: MarkerId('user_location'),
                    position: LatLng(user.location!.latitude, user.location!.longitude),
                    infoWindow: InfoWindow(title: 'User Location'),
                  ),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}

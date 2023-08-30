import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Models/User.dart';
import 'AppState.dart';
import 'CustomDrawer.dart';
import 'UserDetailsScreen.dart';



class Annuaire extends StatefulWidget {
  const Annuaire({super.key});

  @override
  State<Annuaire> createState() => _AnnuaireState();
}

class _AnnuaireState extends State<Annuaire> {
  late Future<List<Users>> usersList;

  @override
  void initState() {
    super.initState();
    usersList = _fetchUsersFromFirestore();
  }

  Future<List<Users>> _fetchUsersFromFirestore() async {
    // Fetch user data from Firestore
    final usersSnapshot = await FirebaseFirestore.instance.collection('users').get();

    // Convert Firestore data into List<Users>
    List<Users> users = usersSnapshot.docs.map((doc) {
      return Users(uid: doc['uid'], email: doc['email'], fullName: doc['fullName'],  phonenumber: doc['phonenumber'],location: doc['location']);
    }).toList();

    return users;
  }

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
    var appState = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text('User Directory'),
      ),
      drawer:  customDrawer(appState.selectedIndex, selectedPlanet: null,) ,
      body: FutureBuilder<List<Users>>(
        future: usersList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(
              backgroundColor: Colors.blueGrey,
              color: Colors.orangeAccent,
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Users> users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                Users user = users[index];
                return Card(
                  elevation: 2,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      //backgroundImage: NetworkImage(user.profileImageUrl ?? 'fallback_image_url'),
                    ),
                    title: Text(user.fullName ?? 'No Name'),
                    onTap: () {
                      // Navigate to a detailed user profile screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserDetailsScreen(user: user)),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),

    );
  }
}
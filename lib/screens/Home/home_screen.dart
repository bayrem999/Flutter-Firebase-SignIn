// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign_in/Services/auth.dart';
import 'package:sign_in/screens/Home/AppState.dart';
import 'package:sign_in/screens/Home/CustomDrawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sign_in/Models/Note.dart';
import 'package:sign_in/Services/noteS.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';


import '../../Models/Planets.dart';
import '../../Services/ThemeService.dart';
import '../Notes/NoteCard.dart';


class home extends StatefulWidget {


  const home({super.key});


  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final AuthService _auth= AuthService();
  final themeService _fontx = themeService();
  String? userId;
  @override
  Widget build(BuildContext context) {

    User? user = FirebaseAuth.instance.currentUser;
     userId = user?.uid;
    var appState = Provider.of<AppState>(context);

    return Scaffold(


      appBar: AppBar(

        title: Text(AppLocalizations.of(context)!.homePage, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontFamily: _fontx.getFontFamilyFromAppFont(Provider.of<AppState>(context).selectedFont),
            fontSize: Provider.of<AppState>(context).fontSize )),
        backgroundColor: Colors.orangeAccent,
        elevation: 0.0,

      ),
      drawer: customDrawer(appState.selectedIndex, selectedPlanet: null,),



      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to My App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            SizedBox(height: 20),
           const Text(
              'Get ready for an amazing experience!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Add navigation logic here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Start Exploring',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }




  }


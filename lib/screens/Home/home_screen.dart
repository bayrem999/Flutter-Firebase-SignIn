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
import '../Notes/NoteCard.dart';


class home extends StatefulWidget {


  const home({super.key});


  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final AuthService _auth= AuthService();
  String? userId;
  @override
  Widget build(BuildContext context) {

    User? user = FirebaseAuth.instance.currentUser;
     userId = user?.uid;
    var appState = Provider.of<AppState>(context);

    return Scaffold(

      backgroundColor: Colors.blueAccent[50],
      appBar: AppBar(

        title: Text(AppLocalizations.of(context)!.homePage, style: TextStyle(fontSize: Provider.of<AppState>(context).fontSize),),
        backgroundColor: Colors.black,
        elevation: 0.0,

      ),
      drawer: customDrawer(appState.selectedIndex),



    );
  }




  }


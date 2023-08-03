// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign_in/Services/auth.dart';
import 'package:sign_in/screens/Home/AppState.dart';
import 'package:sign_in/screens/Home/CustomDrawer.dart';


class home extends StatefulWidget {
  const home({super.key});



  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final AuthService _auth= AuthService();




  @override
  Widget build(BuildContext context) {

    var appState = Provider.of<AppState>(context);

    return Scaffold(

      backgroundColor: Colors.blueAccent[50],
      appBar: AppBar(
        title: Text('Home Page', style: TextStyle(fontSize: Provider.of<AppState>(context).fontSize),),
        backgroundColor: Colors.grey,
        elevation: 0.0,

      ),
      drawer: customDrawer(appState.selectedIndex),

      body: Container(
        decoration: const BoxDecoration(

        ),
        child: const Text('This is home page '),

      ),

    );
  }
}

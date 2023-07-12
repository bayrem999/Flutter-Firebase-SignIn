import 'package:flutter/material.dart';
import 'package:sign_in/Services/auth.dart';


class home extends StatelessWidget {


  final AuthService _auth= AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.blueAccent[50],
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Colors.blueAccent[400],
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),

      body: Container(
        decoration: BoxDecoration(

        ),
        child: Text('This is home page '),

      ),

    );
  }
}

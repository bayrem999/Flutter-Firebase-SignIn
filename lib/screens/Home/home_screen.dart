import 'package:flutter/material.dart';
import 'package:sign_in/Services/auth.dart';


class home extends StatelessWidget {


  final AuthService _auth= AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Brew Crew'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
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

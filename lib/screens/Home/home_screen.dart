import 'package:flutter/material.dart';


class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('HOME PAGE'),
      ),

      body: Container(
        decoration: BoxDecoration(

        ),
        child: Text('This is home page '),

      ),

    );
  }
}

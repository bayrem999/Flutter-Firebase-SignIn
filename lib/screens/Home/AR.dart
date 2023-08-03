import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign_in/screens/Home/AppState.dart';
import 'package:sign_in/screens/Home/CustomDrawer.dart';
class AR extends StatelessWidget {
  const AR({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppState>(context);
    return  Scaffold(

      appBar: AppBar(),
      body: const Center(child: Text("hi oihdfojd,")),
      drawer: customDrawer(appState.selectedIndex),
    );
  }
}

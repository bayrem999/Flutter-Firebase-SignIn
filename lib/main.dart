import 'package:flutter/material.dart';
import 'package:sign_in/screens/Wrapper.dart';
import 'package:sign_in/screens/splach_screen.dart';
import 'package:firebase_core/firebase_core.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  //initilization of Firebase app

  // other Firebase service initialization

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build (BuildContext context ) {

    return const MaterialApp(

      home: splach(),
    );

  }


}

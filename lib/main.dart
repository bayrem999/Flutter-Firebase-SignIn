import 'package:flutter/material.dart';
import 'package:sign_in/Models/User.dart';
import 'package:sign_in/Services/auth.dart';
import 'package:sign_in/screens/Home/AR.dart';
import 'package:sign_in/screens/Home/AppState.dart';
import 'package:sign_in/screens/Home/home_screen.dart';
import 'package:sign_in/screens/Wrapper.dart';
import 'package:sign_in/screens/splach_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  //initilization of Firebase app

  // other Firebase service initialization

  runApp(
    ChangeNotifierProvider<AppState>(
      create: (context) => AppState(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build (BuildContext context ) {

    return  StreamProvider<Users?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(

        title: 'My App',

        routes: {
          '/home': (context) => home(),
          '/ar': (context) => AR(),
        },
        home: splach(),
      ),
    );

  }


}

import 'package:flutter/material.dart';
import 'package:sign_in/screens/Authentification/authenti.dart';
import 'package:sign_in/screens/Home/home_screen.dart';
import 'package:sign_in/screens/splach_screen.dart';

class wrapper extends StatelessWidget {
  const wrapper({super.key});

  @override
  Widget build(BuildContext context) {

    //return home or authentificate
    return authenti();
  }
}

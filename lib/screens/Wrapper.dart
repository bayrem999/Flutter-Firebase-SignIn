import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign_in/Models/User.dart';
import 'package:sign_in/screens/Authentification/authenti.dart';
import 'package:sign_in/screens/Home/home_screen.dart';
import 'package:sign_in/screens/splach_screen.dart';

class wrapper extends StatelessWidget {
  const wrapper({super.key});

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Users?>(context);
    print(user);
    //return home or authentificate
   if(user == null) {
     return authenti();
   } else {
     return home();
   }
  }
}

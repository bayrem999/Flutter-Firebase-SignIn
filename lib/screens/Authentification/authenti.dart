import 'package:flutter/material.dart';
import 'package:sign_in/screens/Authentification/register.dart';
import 'package:sign_in/screens/Authentification/sign_in.dart';

class authenti extends StatefulWidget {
  const authenti({super.key});

  @override
  State<authenti> createState() => _authentiState();
}

class _authentiState extends State<authenti> {

  bool ShowSignIn= true;

  void toggleView(){
    setState(() => ShowSignIn = !ShowSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if(ShowSignIn){
      return SignIn(toggleView: toggleView);
    }else{
      return Register(toggleView: toggleView);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:sign_in/screens/Authentification/sign_in.dart';

class authenti extends StatefulWidget {
  const authenti({super.key});

  @override
  State<authenti> createState() => _authentiState();
}

class _authentiState extends State<authenti> {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: SignIn(),
    );
  }
}

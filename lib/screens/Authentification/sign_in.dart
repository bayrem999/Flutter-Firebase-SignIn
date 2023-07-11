import 'package:flutter/material.dart';
import 'package:sign_in/Services/auth.dart';


class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      Colors.blueGrey[100],
      appBar: AppBar(
        backgroundColor:Colors.blueGrey[400] ,
        elevation: 0.0,
        title: Text("Sign In "),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20 , horizontal: 50),
        child: ElevatedButton(
          child: Text("sign in "),

          onPressed: () async {
            dynamic result = await _auth.SignInAnon();
            if (result == null)
            {
              print("error signing in ") ;
            }
            else
             {
               print("sign in ") ;
            print(result);

            }

          },
        ),


      ),






    );
  }
}

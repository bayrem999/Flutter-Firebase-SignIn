import 'package:flutter/material.dart';
import 'package:sign_in/Services/auth.dart';

class Register extends StatefulWidget {


  final Function  toggleView;
  Register({required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>() ;

  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[400],
        elevation: 0.0,
        title: Text('Sign up '),
        actions: <Widget>[
          TextButton.icon(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            icon: Icon(Icons.person),
            label: Text('Sign In'),
            onPressed: ()  {
              widget.toggleView();

            },
          ),
        ],
      ),
    body: Container(
    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
    child: Form(
      key: _formkey,
    child: Column(
    children: <Widget>[
    SizedBox(height: 20.0),
    TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter an email',
      ),
      validator: (val) => val!.isEmpty ? 'Enter an email ' : null,
    onChanged: (val) {
    setState(() => email = val);
    },
    ),
    SizedBox(height: 20.0),
    TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter a password',
      ),
    obscureText: true,
    validator: (val) => val!.length < 6 ? 'password too short ' : null,
    onChanged: (val) {
    setState(() => password = val);
    },
    ),
    SizedBox(height: 20.0),
    ElevatedButton(


    child: Text(
    'Register',
    style: TextStyle(color: Colors.white),
    ),
    onPressed: () async {
    if (_formkey.currentState?.validate() == true)
    {
        dynamic result = await _auth.registerWithEmailAndPassword(email, password);
        if(result == null)

        {
          setState(() => error = 'Please enter a valid email ' );

        }

    }
    }
    ),
      SizedBox(height: 12.0),
      Text(
        error,
        style: TextStyle(color: Colors.red, fontSize: 14.0),
      ),
    ],
    ),
    ),
    ),
    );
  }
}

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
    return /*Scaffold(
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
    );*/

    // Ui Update




      Scaffold(

        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [
                    Color(0xFFE65100), Color(0xFFEF6C00), Color(0xFFFFA726)
                  ]
              )
          ),

          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 80,),
                const Padding(
                  padding: EdgeInsets.all(20),


                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Register", style: TextStyle(color: Colors.white, fontSize: 40),),


                    ],
                  ),




                ),
                SizedBox(height: 20),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                    ),


                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(30),
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 60,),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [BoxShadow(
                                      color: Color.fromRGBO(225, 95, 27, .3),
                                      blurRadius: 20,
                                      offset: Offset(0, 10)
                                  )]
                              ),
                              child: Form(
                                key: _formkey,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE)))
                                      ),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                            hintText: "Email or Phone number",
                                            hintStyle: TextStyle(color: Colors.grey),
                                            border: InputBorder.none
                                        ),
                                        validator: (val) => val!.isEmpty ? 'enter an email ' : null,
                                        onChanged: (val) {
                                          setState(() => email = val);
                                        },

                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE)))
                                      ),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                            hintText: "Password",
                                            hintStyle: TextStyle(color: Colors.grey),
                                            border: InputBorder.none
                                        ),
                                        validator: (val) => val!.length < 6 ? 'password too short ' : null,
                                        obscureText: true,
                                        onChanged: (val) {
                                          setState(() => password = val);
                                        },

                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: 40,),
                            Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.orange[900]
                              ),
                              child: Center(
                                child: GestureDetector(
                                  onTap: () async {
                                    if (_formkey.currentState?.validate() == true)
                                    {
                                      dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                                      if(result == null)

                                      {
                                        setState(() => error = 'Please enter a valid email ' );

                                      }

                                    }
                                  },

                                    child: Text("Sign up", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
                              ),
                            ),

                            TextButton(onPressed: ()  {
                              widget.toggleView();

                            },  child: Text('you already  have an account ? ') ),


                            SizedBox(height: 30,),


                          ],
                        ),
                      ),
                    ),

                  ),
                ),
              ]
          ),


        ),
      );


  }
}

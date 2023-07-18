import 'package:flutter/material.dart';
import 'package:sign_in/Services/auth.dart';
import 'package:sign_in/screens/Authentification/ForgotPass.dart';


class SignIn extends StatefulWidget {
  final Function  toggleView;
  SignIn({required this.toggleView});


  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>() ;



  // text field state
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
        title: const Text('Sign in '),
        actions: <Widget>[
          TextButton.icon(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: ()  {
              widget.toggleView();

            },
          ),
        ],
      ),
      body: Container(

        width: double.infinity,
        decoration: const BoxDecoration(
            gradient:  LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Color(0xFFFFA500), Color(0xFFFF8C00), Color(0xFFFF7F00)
                ]
            )
        ),
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Column(
          

          children: [


            Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter an email',
                    ),
                    validator: (val) => val!.isEmpty ? 'enter an email ' : null,
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
                    validator: (val) => val!.length < 6 ? 'password too short ' : null,
                    obscureText: true,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                  SizedBox(height: 20.0),

                  GestureDetector(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)
                            {
                              return ForgotPass();
                            }),);

                      },
                      child: Text(" Forgot password ? " , style:TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,) ,)),

                  ElevatedButton(

                      child: Text(
                        'Sign In',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formkey.currentState?.validate() == true)
                        {
                          dynamic result = await _auth.signinWithEmailAndPassword(email, password);

                          if(result == null)

                          {
                            setState(() => error = 'Wrong credentials ' );

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
          ],
        ),
      ),
    );*/

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
    Padding(
    padding: EdgeInsets.all(20),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
     Text("Login", style: TextStyle(color: Colors.white, fontSize: 40),),
    SizedBox(height: 10,),
    Text("Welcome Back", style: TextStyle(color: Colors.white, fontSize: 18),),
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
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE)))
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Email or Phone number",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE)))
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40,),
               Text("Forgot Password?", style: TextStyle(color: Colors.grey),),
              SizedBox(height: 40,),
               Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 50),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.orange[900]
                ),
                child: Center(
                  child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                ),
              ),
              SizedBox(height: 50,),
               Text("Continue with social media", style: TextStyle(color: Colors.grey),),
              SizedBox(height: 30,),
              Row(
                children: <Widget>[
                  Expanded(
                    child:  Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.blue
                      ),
                      child: Center(
                        child: Text("Facebook", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ),
                  SizedBox(width: 30,),
                  Expanded(
                    child:  Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Color(0xFFE53935)
                      ),
                      child: Center(
                        child: Text("Google", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      ),
                    ),
                  )
                ],
              )
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

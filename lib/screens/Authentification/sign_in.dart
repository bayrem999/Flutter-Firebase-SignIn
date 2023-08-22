import 'package:flutter/material.dart';
import 'package:sign_in/Services/auth.dart';
import 'package:sign_in/screens/Authentification/ForgotPass.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SignIn extends StatefulWidget {
  final Function  toggleView;
  const SignIn({super.key, required this.toggleView});


  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>() ;

  bool _isObscured = true;

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
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [Color(0xFFE65100), Color(0xFFEF6C00), Color(0xFFFFA726)],
            ),
          ),
          child: ListView( // Use ListView instead of Column
            children: <Widget>[
              const SizedBox(height: 10,),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Login", style: TextStyle(color: Colors.white, fontSize: 40)),
                    SizedBox(height: 10,),
                    Text("Welcome Back", style: TextStyle(color: Colors.white, fontSize: 18)),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 20,),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(225, 95, 27, .3),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            )
                          ],
                        ),
                        child: Form(
                          key: _formkey,
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE))),
                                ),
                                child: Semantics(
                                  label: AppLocalizations.of(context)!.email,
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      hintText: "Email",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (val) {
                                      if (val == null || val.isEmpty) {
                                        return 'Please enter an email';
                                      } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(val)) {
                                        return 'Please enter a valid email';
                                      }
                                      return null;
                                    },
                                    onChanged: (val) {
                                      setState(() => email = val);
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE))),
                                ),
                                child: Semantics(
                                  label: AppLocalizations.of(context)!.password,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: AppLocalizations.of(context)!.password,
                                      hintStyle: const TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _isObscured ? Icons.visibility : Icons.visibility_off,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isObscured = !_isObscured;
                                          });
                                        },
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                    validator: (val) => val!.length < 6 ? 'password too short ' : null,
                                    obscureText: _isObscured, // Use the obscured state here
                                    onChanged: (val) {
                                      setState(() => password = val);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red),
                  ),
                      const SizedBox(height: 40,),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return const ForgotPass();
                          }));
                        },
                        child: Text(
                          AppLocalizations.of(context)!.forgotPassword,
                          style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 35,),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 50),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.orange[900],
                        ),
                        child: Center(
                          child: InkWell(
                            onTap: () async {
                              if (_formkey.currentState?.validate() == true) {
                                dynamic result = await _auth.signinWithEmailAndPassword(context,email, password);
                                if (result == null) {
                                  setState(() => error = 'Wrong credentials ');

                                }


                              }

                            },
                            child: const Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ),

                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          widget.toggleView();
                        },
                        child: Text(AppLocalizations.of(context)!.youdonthaveanAccount),
                      ),
                      const SizedBox(height: 10,),
                      Text(
                        AppLocalizations.of(context)!.continuewithsocialmedia,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 30,),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child:  Center(
                                child: Image.asset('assets/images/facebook.png', width: 30, height: 30),
                            ),
                          ),
                          const SizedBox(width: 30,),
                          Expanded(
                            child: Center(
                              child: GestureDetector(
                                onTap: () async {
                                  dynamic result = await _auth.signInWithGoogle(context);
                                },
                                  child: Image.asset('assets/images/google.png', width: 30, height: 30),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );



  }
}

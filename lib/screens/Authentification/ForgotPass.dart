import 'package:flutter/material.dart';
import 'package:sign_in/Services/auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>() ;

  String email = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return

     /* Scaffold(
      appBar: AppBar(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular( 30.0),
          ),
        ),
        title: Text("Reset Password"),
      ),
      body:
    Form(
      key: _formkey,
      child:
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [


            Text("Enter your email"),
            SizedBox(height: 20.0),

            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter valid email',
              ),
              validator: (val) => val!.isEmpty ? 'enter an email ' : null,
              onChanged: (val) {
                setState(() => email = val);
              },

            ),
            MaterialButton(onPressed: () async {
              if (_formkey.currentState?.validate() == true)
              {
                dynamic result = await _auth.ResetPassword(email);

                if(result == null)

                {
                  setState(() => error = 'Wrong email ' );

                }

              }

            },
            child: Text("Reset password"),
              color: Colors.blue,

            )


          ],),
      ),
    ),)
    );*/
       Scaffold(


        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
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
                const SizedBox(height: 80,),
                const Padding(
                  padding: EdgeInsets.all(20),


                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Reset password", style: TextStyle(color: Colors.white, fontSize: 40),),


                    ],
                  ),




                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                    ),


                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          children: <Widget>[
                            const SizedBox(height: 60,),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [ BoxShadow(
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
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                          border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE)))
                                      ),
                                      child: Semantics(
                                        label: AppLocalizations.of(context)!.email ,
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                              hintText: "Enter your email",
                                              hintStyle: TextStyle(color: Colors.grey),
                                              border: InputBorder.none
                                          ),

                                          validator: (val) => val!.isEmpty ? 'enter an email ' : null,
                                          onChanged: (val) {
                                            setState(() => email = val);
                                          },

                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 40,),
                            Container(

                              height: 50,
                              margin: const EdgeInsets.symmetric(horizontal: 50),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.orange[900]
                              ),
                              child: Center(
                                child: Semantics(
                                    label: "reset password",
                                  child: GestureDetector(

                                      onTap: ()
                                      async {
                                        if (_formkey.currentState?.validate() == true)
                                        {
                                          dynamic result = await _auth.ResetPassword(email);

                                          if(result == null)

                                          {
                                            setState(() => error = 'Wrong email ' );

                                          }

                                        }

                                      },
                                      child: const Text("Reset password", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
                                ),
                              ),
                            ),



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

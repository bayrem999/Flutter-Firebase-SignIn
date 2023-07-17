import 'package:flutter/material.dart';
import 'package:sign_in/Services/auth.dart';
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
    return Scaffold(
      appBar: AppBar(
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
    );
  }
}

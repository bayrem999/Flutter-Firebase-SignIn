import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:sign_in/Services/auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Register extends StatefulWidget {


  final Function  toggleView;
  const Register({super.key, required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>() ;
  bool _isObscured = true;
  bool _isObscured2 = true;
  String email = '';
  String password = '';
  String nom ='';
  String phonenumber ='';
  String error = '';
  String confirmPassword ='';
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return
    // Ui Update

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
                const SizedBox(height: 20,),
                const Padding(
                  padding: EdgeInsets.all(20),


                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Register", style: TextStyle(color: Colors.white, fontSize: 30),),


                    ],
                  ),




                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                    ),


                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          children: <Widget>[
                            const SizedBox(height: 30,),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const[ BoxShadow(
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
                                        child:  TextFormField(
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
                                        label: 'phonenumber',
                                        child: IntlPhoneField(
                                          decoration: InputDecoration(
                                            hintText: 'Phone number',
                                            hintStyle: TextStyle(color: Colors.grey),
                                            border: InputBorder.none,
                                          ),
                                          initialCountryCode: 'TN',
                                          controller: phoneNumberController,
                                          onChanged: (PhoneNumber phone) {
                                            setState(() {
                                              // Convert the PhoneNumber object to a formatted string
                                              phonenumber = '${phone.countryCode}${phone.number}';
                                            });
                                          },
                                          validator: (PhoneNumber? phone) {
                                            if (phone == null || !phone.isValidNumber()) {
                                              return 'Please enter a valid phone number';
                                            }
                                            return null; // Phone number is valid
                                          },
                                        ),
                                      ),
                                    ),





                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                          border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE)))
                                      ),
                                      child: Semantics(
                                        label: AppLocalizations.of(context)!.password ,
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

                                    Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: const BoxDecoration(
                                            border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE)))
                                        ),
                                        child: Semantics(
                                            label: AppLocalizations.of(context)!.password ,
                                            child: TextFormField(decoration: InputDecoration(
                                              hintText: AppLocalizations.of(context)!.password,
                                              hintStyle: const TextStyle(color: Colors.grey),
                                              border: InputBorder.none,
                                              suffixIcon: IconButton(
                                                icon: Icon(
                                                  _isObscured2 ? Icons.visibility : Icons.visibility_off,
                                                  color: Theme.of(context).primaryColor,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _isObscured2 = !_isObscured2;
                                                  });
                                                },
                                              ),
                                            ),
                                              keyboardType: TextInputType.number,
                                              validator: (val) {
                                                if (val != password) {
                                                  return 'Passwords do not match';
                                                }
                                                return null;
                                              },
                                              obscureText: _isObscured2,
                                              onChanged: (val) {
                                                setState(() => confirmPassword = val);
                                              },)
                                        ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 30,),
                            Semantics(
                              label: AppLocalizations.of(context)!.signUp ,
                              child: Container(
                                height: 50,
                                margin: const EdgeInsets.symmetric(horizontal: 50),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.orange[900]
                                ),
                                child: Center(
                                  child: InkWell(
                                    onTap: () async {
                                      if (_formkey.currentState?.validate() == true)
                                      {
                                        dynamic result = await _auth.registerWithEmailAndPassword(context,email, password,phonenumber);
                                        if(result == null)

                                        {
                                          setState(() => error = 'Please enter a valid email ' );

                                        }

                                      }
                                    },

                                      child:  Text(AppLocalizations.of(context)!.signUp, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
                                ),
                              ),
                            ),

                            Semantics(
                              label: AppLocalizations.of(context)!.youalreadyhaveanAccount ,
                              child: TextButton(onPressed: ()  {
                                widget.toggleView();

                              },  child:  Text(AppLocalizations.of(context)!.youalreadyhaveanAccount,) ),
                            ),


                            //const SizedBox(height: 20,),


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

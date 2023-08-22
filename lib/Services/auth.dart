// ignore_for_file: non_constant_identifier_names, avoid_print



import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:sign_in/Models/User.dart';

class AuthService {


final FirebaseAuth _auth = FirebaseAuth.instance;



Users? _userFromFireBaseUser(User? user) {

  return user != null ? Users(uid: user.uid): null ;

}

// auth change

  Stream<Users?> get user {
    return _auth.authStateChanges()
        //.map((User user)=>_userFromFireBaseUser(user) );
    .map(_userFromFireBaseUser);

  }


  // sign_in anonyme
 Future signInAnon() async {

   try {  UserCredential result = await _auth.signInAnonymously();
   User? user = result.user;
   return _userFromFireBaseUser(user!);

   } catch (e) { print(e.toString());

     return null;

   }



}
  Future<UserCredential> signInWithGoogle(BuildContext context) async {
    showDialog(context: context, builder: (context)
    {
      return const Center(child: CircularProgressIndicator(
        color: Colors.orangeAccent,
        backgroundColor: Colors.blueGrey,
      ));
    },);
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    Navigator.of(context).pop();
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // sign_in with email and pwd

  Future signinWithEmailAndPassword(BuildContext context,String email , String password)async
  {
    showDialog(context: context, builder: (context)
    {
      return const Center(child: CircularProgressIndicator(
        color: Colors.orangeAccent,
        backgroundColor: Colors.blueGrey,));
    },);
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      Navigator.of(context).pop();
      return _userFromFireBaseUser(user);

    }
        catch(e)
        {
          print (e.toString());

          return null ;

        }

  }


  // reset password

  Future ResetPassword(String email) async {
   try{
     await _auth.sendPasswordResetEmail(email: email);
  }catch(e)
   {
     print(e);
   }

}


  // register with email and pwd
  Future registerWithEmailAndPassword(BuildContext context, email , String password) async
  {
    showDialog(context: context, builder: (context)
    {
      return const Center(child: CircularProgressIndicator(
        color: Colors.orangeAccent,
        backgroundColor: Colors.blueGrey,
      ));
    },);
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      Navigator.pop(context);
      return _userFromFireBaseUser(user);
    }
    // ignore: avoid_print
    catch(e){print (e.toString());
      return null ;
    }

  }

  // sign out

  Future signOut(BuildContext context) async {
    showDialog(context: context, builder: (context)
    {
      return const Center(child: CircularProgressIndicator(
        color: Colors.orangeAccent,
        backgroundColor: Colors.blueGrey,));
    },);
    try {
      await _auth.signOut();
      Navigator.of(context).pop();
      return null;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }




}
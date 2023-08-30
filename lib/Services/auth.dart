// ignore_for_file: non_constant_identifier_names, avoid_print



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sign_in/Models/User.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';


class AuthService {


final FirebaseAuth _auth = FirebaseAuth.instance;



Users? _userFromFireBaseUser(User? user) {

  return user != null ? Users(uid: user.uid, email: user.email, fullName: user.displayName,  phonenumber: user.phoneNumber, location: null,): null ;

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

  // sign in with facebook

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  // sign_in with email and pwd

  Future<User?> signinWithEmailAndPassword(BuildContext context, String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      if (user != null) {
        Position position = await getLocation(); // Await the getLocation function

        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'location': GeoPoint(position.latitude, position.longitude),
        });

        Navigator.of(context).pop();
        return user;
      } else {
        Navigator.of(context).pop();
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Position> getLocation() async {
    // Request location permission
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
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
  Future registerWithEmailAndPassword(BuildContext context, email , String password,String phonenumber,String fullName) async
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
      await FirebaseFirestore.instance.collection('users').doc(result.user!.uid).set({

        'uid':"",
        'email': email,
        'fullName': fullName ,
        'phonenumber':phonenumber,

        // Add other user data fields as needed
      });
      User? user = result.user;
      Navigator.of(context).pop();
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
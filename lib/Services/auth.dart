// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:firebase_auth/firebase_auth.dart';

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
  // sign_in with email and pwd

  Future signinWithEmailAndPassword(String email , String password)async
  {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
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
  Future registerWithEmailAndPassword(String email , String password) async
  {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFireBaseUser(user);
    }
    // ignore: avoid_print
    catch(e){print (e.toString());
      return null ;
    }

  }

  // sign out

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }




}
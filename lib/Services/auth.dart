import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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

  // register with email and pwd

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
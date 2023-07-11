import 'package:firebase_auth/firebase_auth.dart';

class AuthService {


final FirebaseAuth _auth = FirebaseAuth.instance;


  // sign_in anonyme
 Future SignInAnon() async {

   try {  UserCredential result = await _auth.signInAnonymously();
   User? user = result.user;
   return user;

   } catch (e) { print(e.toString());

     return null;

   }



}
  // sign_in with email and pwd

  // register with email and pwd

  // sign out

}
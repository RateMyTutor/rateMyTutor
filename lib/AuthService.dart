// import 'package:firebase_auth/firebase_auth.dart';
// class AuthSerivce {
//
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   //signInAnonymously
//
//   Future signInAnonymously() async {
//
//     try{
//        UserCredential result = await _auth.signInAnonymously();
//        FirebaseUser user = result.user;
//        return user.uid;
//     } catch(e){
//       print(e.toString());
//       return null;
//     }// try & catch
//
//   }//signInAnonymously
//
//   //sign in with email and password
//
//   //register with email and password
//
//   //sign out
//
// }// Database(class)
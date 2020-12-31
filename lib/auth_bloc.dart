import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rate_my_tutor/auth_service.dart';

class AuthBloc {

  final authSerice = AuthService();
  final fb = FacebookLogin();
  final googleSignIn = GoogleSignIn(scopes: ['email']);


  Stream<User> get currentUser => authSerice.currentUser;


 Future loginGoogle() async{

    try{
      final GoogleSignInAccount googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      //turn it into generic auth credential
      final AuthCredential credential = GoogleAuthProvider.credential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

      //Firebase sigin in
      final result = await authSerice.signInWithCredential(credential);

      print('${result.user.displayName}');
      return result.user;
    }catch(error){
      print(error);
      print("hello");
      return null;
    }// catch
    return null;

  }// loginGoogle



 Future loginFaceBook() async {
    print("Starting facebook login");
    final res = await fb.logIn(
        permissions: [
          FacebookPermission.publicProfile,
          FacebookPermission.email

        ]
    );

    switch (res.status) {
      case FacebookLoginStatus.success:
        print("It worked");
        //get token
        final FacebookAccessToken fbToken = res.accessToken;

        //convert to Auth Credential
        final AuthCredential credential = FacebookAuthProvider.credential(
            fbToken.token);

        //User Credential to sign in with firebase

        final result = await authSerice.signInWithCredential(credential);

        print('${result.user.displayName} is now logged in');
        return result.user;

        break;
      case FacebookLoginStatus.cancel:
        print("user cancelled the fb login");
        break;
      case FacebookLoginStatus.error:
        print("There was an error");
        break;
    }
    return null;
  } // loginFacebook

  logout(){
    authSerice.logout();
  }

}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:rate_my_tutor/Backend/Database.dart';
import 'package:rate_my_tutor/Screens/loginPage.dart';
import 'package:rate_my_tutor/Screens/signUpPage.dart';
import 'package:rate_my_tutor/auth_bloc.dart';

import 'firstTimeLogin.dart';
import 'homePage.dart';

class InitialScreen extends StatefulWidget {
  static String initialScreenID = "initialScreenID";
  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {

  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    var authBloc = Provider.of<AuthBloc>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 100),
            child: Column(
              children: [
                FlutterLogo(
                  size: 200,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Scopum",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Bariol',
                    fontWeight: FontWeight.bold,
                    fontSize: 36.0,
                  ),
                ),
                SizedBox(height: 100.0,),
                SignInButton(
                  Buttons.Facebook,
                  text: "Login with Facebook",
                  onPressed: () async {
                    setState(() {
                      showSpinner = true; // start spinner
                    });

                    User user =  await authBloc.loginFaceBook();
                    print("User print");
                    print(user);
                    if (user != null) {
                       bool firstLogin = await Database().isFirstLogin(user);
                       setState(() {
                         showSpinner = false; // make the spinner stop spinning
                       });
                      if (firstLogin) {

                        print("Confirmed First time : So go to firstTime page");
                        Navigator.pushNamed(
                            context, FirstTimeLogin.firstTimeLoginPage);
                      } else {
                        Navigator.pushNamed(context, HomePage.homePageID);
                      }
                      print("hello");
                      print(user.displayName);
                      print(user.uid);
                    } //if
                    else{
                      print("Error loggin in with facebook");
                    }

                  }),
                SizedBox(
                  height: 5.0,
                ),
                SignInButton(
                  Buttons.GoogleDark,
                  text: "Login with Google",
                  onPressed: () async{

                  },
                ),
                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      child: Text(
                        "Login",
                        style: TextStyle(

                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Bariol',
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      onTap: (){
                        Navigator.pushNamed(context, LoginPage.loginPageID);
                      },
                    ),
                    SizedBox(
                      width: 18.0,
                    ),
                    InkWell(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(

                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Bariol',
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      onTap: (){
                        Navigator.pushNamed(context, SignUpPage.signUpPageID);
                      },
                    ),
                  ],
                )
              ],
            ),

          ),
        ),
      ),
    );
  }
}

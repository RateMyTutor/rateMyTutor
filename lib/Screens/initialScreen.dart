import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:rate_my_tutor/Screens/loginPage.dart';
import 'package:rate_my_tutor/Screens/signUpPage.dart';

class InitialScreen extends StatefulWidget {
  static String initialScreenID = "initialScreenID";
  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              text: "Continue with Facebook",
              onPressed: () async {
              }
            ),
            SizedBox(
              height: 5.0,
            ),
            SignInButton(
              Buttons.GoogleDark,
              text: "Continue with Google",
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
    );
  }
}

import 'package:rate_my_tutor/AuthService.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'package:rate_my_tutor/Screens/firstTimeLogin.dart';
import 'package:rate_my_tutor/Utilities/bottomNavBar.dart';

import 'signUpPage.dart';
import 'homePage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:rate_my_tutor/auth_bloc.dart';

class LoginPage extends StatefulWidget {

  static String loginPageID = "LoginPage";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  bool hidePassword = true;
  String email;
  String password;


  @override
  Widget build(BuildContext context) {
    var authBloc = Provider.of<AuthBloc>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 70.0, horizontal: 60.0),
                  child: Center(
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.brown.shade800,
                      child: Text(
                          'ICON'
                      ),
                    ),
                  ),
                ),
                Text(
                  'Email Address',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                  onChanged: (value){
                    email = value;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email Address',
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                  onChanged: (value){
                    password = value;
                  },
                  obscureText: hidePassword,
                  decoration: InputDecoration(
                      suffix: InkWell(
                        onTap: (){
                          setState(() {
                            hidePassword = hidePassword == true ? false : true;
                          });
                        },
                        child: Icon(Icons.visibility),
                      ),
                      border: OutlineInputBorder(),
                      labelText: 'Password'
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      onPressed: () async {
                        //TODO: Go to home
                        setState(() {
                          //make the spinner spin
                          showSpinner = true;
                        });
                        try{
                          final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
                          if(user != null) {
                            Navigator.pushNamed(context, BottomNavBar.bottomNavBarID);
                          }// if
                        }catch(e){
                          print(e.toString());
                        }//catch

                        setState(() {
                          showSpinner = false;
                        });

                      },// onPressed

                      color: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text("Login"),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    //Sign up Button
                    RaisedButton(
                      onPressed: () async {
                        //TODO: Go to SignUp Page
                        Navigator.pushNamed(context,SignUpPage.signUpPageID);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(builder: (context) => AddReviewPage()));
                      },
                      color: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text("Sign Up"),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SignInButton(
                        Buttons.Facebook,
                        onPressed: () async {
                          User user =  await authBloc.loginFaceBook();
                          print("User print");
                          print(user);
                          if(user != null) {
                            bool firstLogin = await isFirstLogin(user);
                            if(firstLogin){
                              print("Confirmed First time : So go to firstTime page");
                              Navigator.pushNamed(context, FirstTimeLogin.firstTimeLoginPage);
                            }else{
                              Navigator.pushNamed(context, HomePage.homePageID);
                            }
                            print("hello");
                            print(user.displayName);
                            print(user.uid);
                          }; // if

                        },
                      ),
                      SignInButton(
                        Buttons.GoogleDark,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        onPressed: () async{
                          User user = await authBloc.loginGoogle();
                          print("Logged in with google");
                          if(user != null){
                            bool firstLogin = await isFirstLogin(user);
                            if(firstLogin){
                              print("Confirmed First time : So go to firstTime page");
                              Navigator.pushNamed(context, FirstTimeLogin.firstTimeLoginPage);
                            }else {
                              Navigator.pushNamed(context, HomePage.homePageID);
                            }
                            print(user.email);
                            print(user.uid);
                            Navigator.pushNamed(context, HomePage.homePageID);
                          }else{
                            print(user);
                            print("Failed");
                          }

                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }// build

// method checks if the user is logging in for the first time or not
  Future<bool> isFirstLogin(User user) async{

    DocumentSnapshot doc = await  db.collection("Users").doc(user.uid).get();
    if(doc.exists){
      return false;
    }else{
      print("Document doesn't exist, so user is first time logging in");
      return true;
    }
  }// isFirstLogin

}// class


//TODO: Facebook sign in
//   SignInButton(
//   Buttons.Facebook,
//   onPressed: () async {
//   User user =  await authBloc.loginFaceBook();
//   print("User print");
//   print(user);
//   if(user != null) {
//   bool firstLogin = await isFirstLogin(user);
//   if(firstLogin){
//   print("Confirmed First time : So go to firstTime page");
//   Navigator.pushNamed(context, FirstTimeLogin.firstTimeLoginPage);
//   }else{
//   Navigator.pushNamed(context, HomePage.homePageID);
//   }
//   print("hello");
//   print(user.displayName);
//   print(user.uid);
//   }; // if
//
// },
// ),


//TODO: Google sign-in
// SignInButton(
// Buttons.GoogleDark,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(20.0)),
// onPressed: () async{
// User user = await authBloc.loginGoogle();
// print("Logged in with google");
// if(user != null){
// bool firstLogin = await isFirstLogin(user);
// if(firstLogin){
// print("Confirmed First time : So go to firstTime page");
// Navigator.pushNamed(context, FirstTimeLogin.firstTimeLoginPage);
// }else{
// Navigator.pushNamed(context, HomePage.homePageID);
// }
//
// print(user.email);
// print(user.uid);
// Navigator.pushNamed(context, HomePage.homePageID);
// }else{
// print(user);
// print("Failed");
// }
//
// },
// ),


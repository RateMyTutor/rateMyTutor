import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:rate_my_tutor/AuthService.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:rate_my_tutor/Screens/firstTimeLogin.dart';

import 'package:rate_my_tutor/Utilities/bottomNavBar.dart';
import 'homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:rate_my_tutor/Models/UserArg.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:rate_my_tutor/auth_bloc.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatefulWidget {
  static String loginPageID = "LoginPage";
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // This widget is the root of your application.
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final db = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  String userName;
  String status;
  List statusOptions = ['O-Level', 'A-Level (AS)', 'A-Level (A2)', 'Other'];
  bool hidePassword = true;
  bool showSpinner = false;
  bool checkedValue = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 16.0),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      iconSize: 35,
                      color: Color(0xFF2F80ED),
                      icon: Icon(
                        Icons.arrow_back,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 27.0.sp,
                          fontFamily: 'Bariol',
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 25.0, bottom: 6.0),
                  child: Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Bariol',
                      color: Colors.black,
                    ),
                  ),
                ),
                TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Required";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFE0E0E0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                        borderRadius: BorderRadius.all(
                          const Radius.circular(21.0),
                        ),
                      ),
                    )),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 25.0, bottom: 6.0),
                  child: Text(
                    'Password',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Bariol',
                      color: Colors.black,
                    ),
                  ),
                ),
                TextFormField(
                    obscureText: hidePassword,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Required'),
                      EmailValidator(errorText: 'Not a valid email')
                    ]),
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            hidePassword = hidePassword == true ? false : true;
                          });
                        },
                        child: Icon(hidePassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                      filled: true,
                      fillColor: Color(0xFFE0E0E0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                        borderRadius: BorderRadius.all(
                          const Radius.circular(21.0),
                        ),
                      ),
                    )),
                SizedBox(
                  height: 29.0,
                ),
                CheckboxListTile(
                  title: Text(
                    "Keep Me Signed In",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Bariol',
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                  value: checkedValue,
                  onChanged: (newValue) {
                    setState(() {
                      checkedValue = newValue;
                    });
                  },
                  controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
                ),
                SizedBox(
                  height: 40.0,
                ),
                ButtonTheme(
                  minWidth: 245,
                  height: 53,
                  child: FlatButton(
                    color: Color(0xFF2F80ED),
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(26.5)),
                    onPressed: () async {
                      setState(() {
                        //make the spinner spin
                        showSpinner = true;
                      });
                      try {
                        final user = await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        if (user != null) {
                          Navigator.pushNamed(
                              context, BottomNavBar.bottomNavBarID);
                        } // if
                      } catch (e) {
                        print(e.toString());
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    }, // try

                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Color(0xFFF2F2F2),
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

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

import 'package:rate_my_tutor/AuthService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rate_my_tutor/Screens/tutorPage.dart';
import 'signUpPage.dart';
import 'homePage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rate_my_tutor/Models/UserArg.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
class LoginPage extends StatefulWidget {

  static String loginPageID = "LoginPage";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  bool hidePassword = true;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 100.0, horizontal: 60.0),
                  child: Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.brown.shade800,
                      child: Text(
                          'APP'
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
                            Navigator.pushNamed(context, HomePage.homePageID);
                          }// if
                        }catch(e){
                          print(e.toString());
                        }
                        setState(() {
                          showSpinner = false;
                        });

                      },// try
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
                        //Navigator.pushNamed(context,SignUpPage.signUpPageID);
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TutorPage()));
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
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
    );
  }
}



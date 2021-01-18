import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rate_my_tutor/Screens/homePage.dart';
import 'package:rate_my_tutor/Screens/signUpPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rate_my_tutor/Utilities/bottomNavBar.dart';

class FirstTimeLogin extends StatefulWidget {
  static String firstTimeLoginPage = "firstTimeLoginPage";
  @override
  _FirstTimeLoginState createState() => _FirstTimeLoginState();
}

class _FirstTimeLoginState extends State<FirstTimeLogin> {
  final uAuth =  FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  String username;
  String status;
  List statusOptions = ['O-Level','A-Level (AS)','A-Level (A2)','Other'];

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void validate() async {
    if(formkey.currentState.validate()){
      await addUserToDb(uAuth.currentUser);
      Navigator.pushNamed(context, BottomNavBar.bottomNavBarID);
    }else{
      print("Failed validation");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(
          25.0
        ),
        child: Center(
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome To Rate My Tutor",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  validator: (value){
                    if(value.isEmpty){
                      return "Required";
                    }else{
                      return null;
                    }
                  },
                  onChanged: (value){
                    username = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(

                    ),
                    labelText: "Username",

                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  onPressed: () async {
                    //TODO: add user to database
                    // addUserToDb(uAuth.currentUser);
                    // //TODO: go to home page
                    // Navigator.pushNamed(context,HomePage.homePageID);
                    // this function checks if its validated, then adds user to db and goes to home screen
                    await validate();
                  },
                  color: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text("Let's get started"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }// build

void addUserToDb(User user) async {
    print("Adding user to DATABASE");
    print("Username " + username);
  await db.collection("Users").doc(user.uid).set(
      {
        "username" : username,
        "userID" : user.uid,
      }).then((_){
    //if successful, go to home page
    Navigator.pushNamed(context, HomePage.homePageID);
  });

}// addUserToDb
}// class

import 'package:flutter/material.dart';
import 'homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rate_my_tutor/Models/UserArg.dart';
import 'homePage.dart';
class SignUpPage extends StatefulWidget {
  static String signUpPageID = "signUpPage";
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // This widget is the root of your application.
  final db = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  String userName;
  String status;
  List statusOptions = ['O-Level','A-Level (AS)','A-Level (A2)','Other'];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: Padding(
            padding: const EdgeInsets.fromLTRB(16.0,30.0,16.0,16.0),
            child: Column(
              children: [
                SafeArea(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          fontSize: 30
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30.0,),
                TextField(
                  onChanged: (value){
                    userName = value;
                  },
                    decoration: InputDecoration(
                        hintText: 'Username',
                        border: OutlineInputBorder()
                    )
                ),
                SizedBox(height: 20.0,),
                TextField(
                    onChanged: (value){
                      email = value;
                    },
                    decoration: InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder()
                    )
                ),
                SizedBox(height: 20.0,),
                TextField(
                    onChanged: (value){
                      password = value;
                    },
                    decoration: InputDecoration(
                        hintText: 'Password',
                        border: OutlineInputBorder()
                    )
                ),
                SizedBox(height: 20.0,),
                TextField(
                    decoration: InputDecoration(
                        hintText: 'Confirm password',
                        border: OutlineInputBorder()
                    )
                ),
                SizedBox(height: 20.0,),
                DropdownButton(
                  hint: Text('Select an option:'),
                  dropdownColor: Colors.grey,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 36,
                  isExpanded: true,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22
                  ),
                  value: status,
                  onChanged: (newValue) {
                    setState((){
                      status = newValue;
                    });
                  },
                  items: statusOptions.map((valueItem){
                    return DropdownMenuItem(
                      value: valueItem,
                      child: Text(valueItem),
                    );
                  }).toList(),
                ),
                ElevatedButton(
                    onPressed: () async{
                      try{
                        final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                        if(newUser != null){
                          final  user = UserArg(newUser.user.uid,userName,status);
                          print(newUser.user.uid);

                          //Add User to database
                          await db.collection("Users").doc(user.getUserID()).set(
                              {
                                "username" : userName,
                                "status" : status,
                                "userID" : user.getUserID(),

                              }).then((_){
                            //if successful, go to home page
                            Navigator.pushNamed(context, HomePage.homePageID);
                          });
                        }
                      }catch(e){
                        print(e.toString());
                      }
                      //sign up the user

                    },
                    child: Text('Get Started!'),
                ),
              ],
            ),
          ),
        )
    );
  }
}


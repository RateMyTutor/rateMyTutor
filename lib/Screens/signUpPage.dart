import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rate_my_tutor/Screens/firstTimeLogin.dart';
import 'homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rate_my_tutor/Models/UserArg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:sizer/sizer.dart';

class SignUpPage extends StatefulWidget {
  static String signUpPageID = "signUpPage";
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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


  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return MaterialApp(
        home: Scaffold(
          body: Container(
            height: height,
            width: width,
            child: SingleChildScrollView(
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
                            color: Color(0xff583CDF),
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
                            'Create an Account',
                            style: TextStyle(
                                fontSize: 27.0.sp,
                                fontFamily: 'Bariol',
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 18.0.sp,
                      ),

                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 25.0, bottom: 6.0),
                        child: Text(
                          'Username',
                          style: TextStyle(
                            fontSize: 14.0.sp,
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
                            userName = value;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFe7eaf0),
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
                        height: 15.0.sp,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 25.0, bottom: 6.0),
                        child: Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 14.0.sp,
                            fontFamily: 'Bariol',
                            color: Colors.black,
                          ),
                        ),
                      ),
                      TextFormField(
                          validator: MultiValidator(
                              [
                                RequiredValidator(errorText: 'Required'),
                                EmailValidator(errorText: 'Not a valid email')
                              ]
                          ),
                          onChanged: (value) {
                            email = value;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFe7eaf0),
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
                        height: 15.0.sp,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 25.0, bottom: 6.0),
                        child: Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 14.0.sp,
                            fontFamily: 'Bariol',
                            color: Colors.black,
                          ),
                        ),
                      ),
                      TextFormField(
                          obscureText: hidePassword,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Required";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            password = value;
                          },

                          decoration: InputDecoration(
                            suffixIcon: InkWell(
                              onTap: (){
                                setState(() {
                                  hidePassword = hidePassword == true ? false : true;
                                });
                              },
                              child: Icon(hidePassword ? Icons.visibility_off : Icons.visibility),
                            ),
                            filled: true,
                            fillColor: Color(0xFFe7eaf0),
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
                        height: 15.0.sp,
                      ),
                      SizedBox(
                        height: 15.0.sp,
                      ),
                      ButtonTheme(
                        minWidth: 245,
                        height: 53,
                        child: FlatButton(
                          color: Color(0xff583CDF),
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(26.5)),
                          onPressed: () async {
                            if (formkey.currentState.validate()) {
                              try {
                                final newUser =
                                await _auth.createUserWithEmailAndPassword(
                                    email: email, password: password);
                                if (newUser != null) {
                                  final user =
                                  UserArg(userID : newUser.user.uid, username: userName);
                                  print(newUser.user.uid);

                                  Navigator.pushNamed(context, FirstTimeLogin.firstTimeLoginPage);

                                  // //Add User to database
                                  // await db
                                  //     .collection("Users")
                                  //     .doc(user.getUserID())
                                  //     .set({
                                  //   "username": userName,
                                  //   "userStatus": status,
                                  //   "userID": user.getUserID(),
                                  // }).then((_) {
                                  //   //if successful, go to home page
                                  //   Navigator.pushNamed(context, HomePage.homePageID);
                                  // });
                                }
                              } catch (e) {
                                print(e.toString());
                              }
                            } else {
                              print("Failed validation");
                            }
                            //sign up the user
                          },
                          child: Text(
                            'Sign Up',
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
          ),
        ));
  }
}
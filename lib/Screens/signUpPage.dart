import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rate_my_tutor/Models/UserArg.dart';
import 'package:form_field_validator/form_field_validator.dart';

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
                      'Create an Account',
                      style: TextStyle(
                          fontSize: 36,
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
                    'Username',
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
                      userName = value;
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
                    'Email',
                    style: TextStyle(
                      fontSize: 18,
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField(
                    validator: (value) {
                      if (value == null) {
                        return "Required";
                      } else {
                        return null;
                      }
                    },
                    hint: Text('Select an option:'),
                    dropdownColor: Colors.grey[200],
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 36,
                    isExpanded: true,
                    style: TextStyle(color: Colors.black, fontSize: 22),
                    value: status,
                    onChanged: (newValue) {
                      setState(() {
                        status = newValue;
                      });
                    },
                    items: statusOptions.map((valueItem) {
                      return DropdownMenuItem(
                        value: valueItem,
                        child: Text(valueItem),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ButtonTheme(
                  minWidth: 245,
                  height: 53,
                  child: FlatButton(
                    color: Color(0xFF2F80ED),
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
                                UserArg(newUser.user.uid, userName, status);
                            print(newUser.user.uid);

                            //Add User to database
                            await db
                                .collection("Users")
                                .doc(user.getUserID())
                                .set({
                              "username": userName,
                              "status": status,
                              "userID": user.getUserID(),
                            }).then((_) {
                              //if successful, go to home page
                              Navigator.pushNamed(context, HomePage.homePageID);
                            });
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
    ));
  }
}

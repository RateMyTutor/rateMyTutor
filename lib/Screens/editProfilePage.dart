import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rate_my_tutor/Models/UserArg.dart';
import 'package:sizer/sizer.dart';
import 'package:rate_my_tutor/Backend/Database.dart';


class EditProfilePage extends StatefulWidget {
  static String EditProfilePageID = "EditProfilePageID";
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final uAuth =  FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  String username;
  TextEditingController controller;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    UserArg currentUser = Database().getUserFromDB(uAuth.currentUser.uid) as UserArg;
    String currentUsername = currentUser.getUsername();

    controller = new TextEditingController(text: currentUsername);
  }
  void validate() async {
    if(formkey.currentState.validate()){
      //await addUserToDb(uAuth.currentUser);
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(""),
      ));
    }else{
      print("Failed validation");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0.h,horizontal: 5.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Edit Username",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0.sp,
                  fontFamily: 'bariol',
                ),
              ),
            ),
            Center(
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller:controller ,
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
                      child: Text("Update"),
                    ),
                  ],
                ),
              ),
            ),
        ],),
      ),
      );

  }// build
}//class

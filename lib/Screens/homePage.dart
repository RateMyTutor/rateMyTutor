import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rate_my_tutor/Models/Tutor.dart';
import 'package:rate_my_tutor/Screens/loginPage.dart';
import 'package:rate_my_tutor/Models/Tutor.dart';
import 'package:rate_my_tutor/Screens/tutorSearch.dart';




class HomePage extends StatefulWidget {

  static String homePageID = "homePage";
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  final FirebaseAuth uAuth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  SearchBar searchBar;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: (){
                showSearch(context: context, delegate: TutorSearch());
              },
          ),
        ],
        title: Text('Search for Tutor'),
    leading: IconButton(
    icon: Icon(Icons.logout),
    onPressed: () async {

      // for (UserInfo userInfo in uAuth.currentUser.providerData) {
      // if (userInfo.providerId.compareTo("facebook.com") == 0) {
      //   print(userInfo.providerId);
      //   print("Lets sign out " + uAuth.currentUser.displayName);
      //   uAuth.signOut();
      //
      // }
      //
      // }

      uAuth.signOut();
      Navigator.pushNamed(context,LoginPage.loginPageID);

      print("USer ID : " + uAuth.currentUser.uid);
      print("Lets see if we can still see it ");
      print(uAuth.currentUser.displayName);

    },
    ),
    ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(uAuth.currentUser.displayName);
    print(uAuth.currentUser.providerData);
    getUsername();
  }


  
  void getUsername() async{

    return await db.collection("Users").doc(uAuth.currentUser.uid).get().then((value){
      print(value.data());
    });
  }
}



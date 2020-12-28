import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rate_my_tutor/Models/Tutor.dart';
import 'package:rate_my_tutor/Screens/loginPage.dart';
import 'package:rate_my_tutor/Models/Tutor.dart';




class HomePage extends StatefulWidget {
  static String homePageID = "homePage";
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  final _auth = FirebaseAuth.instance;
  dynamic tutorList = [];
  final User currentUser = FirebaseAuth.instance.currentUser;
  final firestoreInstance = FirebaseFirestore.instance;
  SearchBar searchBar;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search for Tutor'),
    leading: IconButton(
    icon: Icon(Icons.logout),
    onPressed: (){
      tutorList = TutorSearch.getTutorsFromDB();

      for( Tutor tutor in tutorList){
          print(tutor.tutorName);
      }
    },
    ),
    ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsername();
  }


  
  void getUsername() async{
    return await firestoreInstance.collection("Users").doc(currentUser.uid).get().then((value){
      print(value.data());
    });;
  }
}



class TutorSearch extends SearchDelegate<String> {

  final _auth = FirebaseAuth.instance;
  static final _db = FirebaseFirestore.instance;
  var tutorUsernames = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    //actions for app bar
    return [
      IconButton(
          icon: Icon(
              Icons.clear,
          ),
          onPressed: (){
      }),
    ];
    throw UnimplementedError();
  }// buildActions

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    // leading icon in the appbar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow ,
        progress: transitionAnimation,
      ),
      onPressed: (){

      },
    );
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {

    // TODO: implement buildResults
    // show some result based on the selection
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    //show when someone searches for something


    throw UnimplementedError();
  }// buildSuggestions

  static Future getTutorsFromDB() async {
    dynamic tutorList = [];
    final tutors = await _db.collection("Tutors").get();
    for( var tutor in tutors.docs){
      final newTutor = Tutor(tutorName: tutor.data()["tutorName"], tutorID: tutor.data()["tutorID"], tutorLocation:
      tutor.data()["tutorLocation"], tutorRating: tutor.data()["tutorRating"],tutorSubject: tutor.data()["tutorSubject"]);
      tutorList.add(newTutor); // add to the list
      }// for loop
    return tutorList;

  }// getTutorsFromDB

}

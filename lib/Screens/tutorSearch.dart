 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rate_my_tutor/Models/Tutor.dart';
import 'package:rate_my_tutor/Screens/dummyScreen.dart';
import 'package:rate_my_tutor/Screens/tutorPage.dart';

class TutorSearch extends SearchDelegate<String> {


  final _auth = FirebaseAuth.instance;
  static final _db = FirebaseFirestore.instance;
  List<Tutor> tutorList = [];
  var tutorUsernames = [];
  var tutorSubjects = [];
  var tutorInsituitions = [];
  var tutorCurriculum = [];

  void fillTutorUsername() async{
    if(tutorUsernames.isNotEmpty){
      return;
    }

    for(Tutor tutor in tutorList){
      print(tutor.tutorName);
      tutorUsernames.add(tutor.tutorName);
      // tutorSubjects.add(tutor.tutorSubject);
      // tutorInsituitions.add(tutor.tutorInstituition);
      // tutorCurriculum.add(tutor.tutorCurriculum);
    }

  }

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
            query = "";
          }),
    ];
    throw UnimplementedError();
  }// buildActions

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    // leading icon in the appbar

    print("calling to fill tutor names");
    if(tutorList.isEmpty){
      getTutorsFromDB();
    }else{
      print("Trying to get it second time");
      for(Tutor tutor in tutorList){
        print(tutor.tutorSubject + " " + tutor.tutorName + "\n");
      }
    }

    // if(tutorUsernames.isEmpty){
    //   fillTutorUsername();
    // }

    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow ,
        progress: transitionAnimation,
      ),
      onPressed: (){
        tutorList.clear();
        tutorUsernames.clear();
        // tutorInsituitions.clear();
        // tutorSubjects.clear();
        close(context, null);
      },
    );
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    print("From build results " + query);
    return buildSuggestions(context);
    // show some result based on the selection
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context)  {
    print(query);
    final emptyList = [];
    List list = (query.isEmpty ? emptyList : tutorList.where((p) => p.tutorName.toUpperCase().startsWith(query.toUpperCase())).toList()) ;
    print(list);

    // TODO: implement buildSuggestions
    //show when someone searches for something

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: (){
          //go to the selected tutor page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TutorPage(tutorObject: list[index]),
            ),
          );
        },
        leading: Icon(Icons.school),
        title: RichText(text: TextSpan(
          // text: tutorList[index].tutorName.substring(0,query.length);
           text: list[index].tutorName.substring(0,query.length),
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          children: [TextSpan(
              text: list[index].tutorName.substring(query.length),
              // text: list[index].substring(query.length),
              style: TextStyle(
                  color: Colors.grey)),
          ],
        ),
        ),
        subtitle: Text(
          tutorList[tutorList.indexOf(list[index])].getTutorSubject() + " (" + tutorList[tutorList.indexOf(list[index])].tutorCurriculum + ")",
        ),
      ),
      itemCount: list.length,
    );
    throw UnimplementedError();
  }// buildSuggestions

  // method fils up the tutors
  void getTutorsFromDB() async {
    if(tutorList.isNotEmpty){
      return;
    }
    final tutors = await _db.collection("Tutors").get();
    print(tutors.size);
    for( var tutor in tutors.docs){
      final newTutor = Tutor(tutorName: tutor.data()["tutorName"], tutorID: tutor.data()["tutorID"], tutorLocation:
      tutor.data()["tutorLocation"],  tutorRating:double.parse(tutor.data()["tutorRating"]),tutorSubject: tutor.data()["tutorSubject"], tutorInstituition: tutor.data()['tutorInstituition'],
          tutorCurriculum: tutor.data()['tutorCurriculum']);
      tutorList.add(newTutor); // add to the list
    }// for loop



  }// getTutorsFromDB






}

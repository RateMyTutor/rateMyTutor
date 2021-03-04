
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rate_my_tutor/Backend/Database.dart';
import 'package:rate_my_tutor/Models/Query.dart';
import 'package:rate_my_tutor/Models/Tutor.dart';
import 'package:rate_my_tutor/Screens/tutorPage.dart';

class AdvancedSearchResults extends StatefulWidget {
  final Query queryObject;

  AdvancedSearchResults({@required this.queryObject});

  @override
  _AdvancedSearchResultsState createState() => _AdvancedSearchResultsState();
}

class _AdvancedSearchResultsState extends State<AdvancedSearchResults> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:FutureBuilder(
          future: Database().advancedSearchFromDB(
              widget.queryObject.querySubject, widget.queryObject.queryCurriculum,
              widget.queryObject.queryClassStatus, widget.queryObject.queryLocation
          ),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              print("coming here");
              return Center(
                child: Container(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              print("COming here and length " + snapshot.data.length.toString());
              return ListView.builder(
               itemBuilder: (context, index) => ListTile(
                   onTap: (){
                   // go to the selected tutor page
                    Navigator.push(
                     context,
                     MaterialPageRoute(
                         builder: (context) => TutorPage(tutorObject: snapshot.data[index]),
                      ),
                    );
                   },
                 trailing: Text(
                     "Rating: " + snapshot.data[index].tutorRating.toString(),
                   style: TextStyle(
                     fontWeight: FontWeight.bold,
                     fontSize: 15.0,
                   ),
                 ),
                  leading: Icon(Icons.school),
                  title: Text(
                       snapshot.data[index].tutorName,
                  ),
                  subtitle: Text(
                    snapshot.data[index].getTutorSubject(),
                     // snapshot.data[index].+ " (" + tutorList[index].tutorCurriculum + ")",
                 ),
               ),
                 itemCount: snapshot.data.length,
              );

            }// else
           }),

    );
  }
}

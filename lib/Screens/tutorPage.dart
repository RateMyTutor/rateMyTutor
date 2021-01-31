import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:rate_my_tutor/Backend/Database.dart';
import 'package:rate_my_tutor/Models/Review.dart';
import 'package:rate_my_tutor/Models/Tutor.dart';
import 'package:rate_my_tutor/Screens/addReviewPage.dart';
import 'package:sizer/sizer.dart';

class TutorPage extends StatefulWidget {

  Tutor tutorObject;

  TutorPage({@required this.tutorObject});

  @override
  _TutorPageState createState() => _TutorPageState();
}

class _TutorPageState extends State<TutorPage> {
  List<Review> reviewList = [];
  final firestoreInstance = FirebaseFirestore.instance;
  final _db = FirebaseFirestore.instance;
  ScrollController _scrollController = new ScrollController();



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 40.0, right: 16.0),
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.tutorObject.tutorName,
                  style: TextStyle(fontSize: 24),
                ),
                Text(
                  widget.tutorObject.tutorSubject,
                  style: TextStyle(fontSize: 20),
                ),
                Text(widget.tutorObject.tutorInstituition,
                    style: TextStyle(fontSize: 20)),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Rating: '+ widget.tutorObject.tutorRating.toString() +'/5',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Reviews',
                  style: TextStyle(fontSize: 24),
                ),
                Container(
                  child: FutureBuilder(
                      future: Database().getTutorReviewsFromDB(widget.tutorObject.tutorID),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return Center(
                            child: Container(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else {
                          return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      FittedBox(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              snapshot.data[index].reviewerUsername,
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 1.0.w,
                                            ),
                                            Container(
                                              color: Colors.blue[50],
                                              child: Text(
                                                snapshot.data[index].reviewerStatus,
                                                 // "${formatDate(snapshot.data[index].reviewTime.day, snapshot.data[index].reviewTime.month, snapshot.data[index].reviewTime.year)}",
                                                  style: TextStyle(fontSize: 18)),
                                            ),
                                            SizedBox(
                                              width: 1.0.w,
                                            ),
                                            Container(
                                              color: Colors.purple[50],
                                              child: Text(
                                                  snapshot.data[index].reviewSubject,
                                                  // "${formatDate(snapshot.data[index].reviewTime.day, snapshot.data[index].reviewTime.month, snapshot.data[index].reviewTime.year)}",
                                                  style: TextStyle(fontSize: 18)),
                                            ),
                                            SizedBox(
                                              width: 1.0.w,
                                            ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Text(
                                                "${formatDate(snapshot.data[index].reviewTime.day, snapshot.data[index].reviewTime.month, snapshot.data[index].reviewTime.year)}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),

                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      FittedBox(
                                        child: Row(
                                          children: [
                                            Text(
                                                'Rating: '+ snapshot.data[index].reviewRating.toString()+'/5',
                                              style: TextStyle(
                                                fontSize: 18
                                              ),
                                            ),
                                            SizedBox(
                                              width: 6,
                                            ),
                                            Container(
                                              color: Colors.pink[50],
                                              child: Text(
                                                  snapshot
                                                      .data[index].reviewFilter,
                                                  style: TextStyle(fontSize: 16)),
                                            ),
                                          ],
                                        ),
                                      ),

                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        truncateText(snapshot.data[index].reviewText),
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        }
                      }),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightBlueAccent,
          foregroundColor: Colors.black,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddReviewPage(tutorObject: widget.tutorObject,)),).then((value) => setState((){
                  _scrollController.jumpTo(0.0);}));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  // Future<List<Review>> getReviewsFromDB() async {
  //   List<Review> reviewList = [];
  //   print(widget.tutorObject.tutorID);
  //   final reviews = await _db
  //       .collection("Reviews")
  //       .where("reviewTutorID", isEqualTo: widget.tutorObject.tutorID)
  //       .get();
  //   for (var review in reviews.docs) {
  //     final newReview = Review(
  //         reviewerID: review["reviewerID"],
  //         reviewerStatus: review["reviewerStatus"],
  //         reviewTutorID: review["reviewTutorID"],
  //         reviewRating: review["reviewRating"].toInt(),
  //         reviewFilter: review["reviewFilter"],
  //         reviewText: review["reviewText"]);
  //     print(newReview);
  //     reviewList.add(newReview);
  //
  //   } // for loop
  //   print(reviewList);
  //   return reviewList;
  // }

  String truncateText(String text) {
    int cutoff = 170;
    return (text.length <= cutoff)
        ? text
        : '${text.substring(0, cutoff)}...';
  }


  String formatDate(int day, int month, int year){
   //TODO:  do a switch statement for months later
    String monthName;
    switch(month){

      case 1: {
        monthName = "Jan";
      }
      break;
      case 2: {
        monthName = "Feb";
      }
      break;
      case 3: {
        monthName = "Mar";
      }
      break;
      case 4: {
        monthName = "Apr";
      }
      break;
      case 5: {
        monthName = "May";
      }
      break;
      case 6: {
        monthName = "Jun";
      }
      break;
      case 7: {
        monthName = "Jul";
      }
      break;
      case 8: {
        monthName = "Aug";
      }
      break;
      case 9: {
        monthName = "Sept";
      }
      break;
      case 10: {
        monthName = "Oct";
      }
      break;
      case 11: {
        monthName = "Nov";
      }
      break;
      case 12: {
        monthName = "Dec";
      }
      break;
    }

    return "${monthName} ${day} ${year}";

  }
}

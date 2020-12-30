import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rate_my_tutor/Models/Review.dart';

class TutorPage extends StatefulWidget {
  @override
  _TutorPageState createState() => _TutorPageState();
}

class _TutorPageState extends State<TutorPage> {
  List<Review> reviewList = [];
  final firestoreInstance = FirebaseFirestore.instance;
  final _db = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 40.0, right: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Smriti Dhiman',
                  style: TextStyle(fontSize: 24),
                ),
                Text(
                  'Rating: ',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Ex-math teacher at Scholastica',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'MATH',
                  style: TextStyle(fontSize: 20),
                ),
                Text('Location: Academia (Gulshan)',
                    style: TextStyle(fontSize: 20)),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Reviews',
                  style: TextStyle(fontSize: 24),
                ),
                Container(
                  child: FutureBuilder(
                      future: getReviewsFromDB(),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Saadman13',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          SizedBox(
                                            width: 130,
                                          ),
                                          Container(
                                            color: Colors.pink[50],
                                            child: Text(
                                                snapshot
                                                    .data[index].reviewerStatus,
                                                style: TextStyle(fontSize: 18)),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            color: Colors.pink[50],
                                            child: Text(
                                                snapshot
                                                    .data[index].reviewFilter,
                                                style: TextStyle(fontSize: 18)),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        snapshot.data[index].reviewText,
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
      ),
    );
  }

  Future<List<Review>> getReviewsFromDB() async {
    List<Review> reviewList = [];
    final reviews = await _db
        .collection("Reviews")
        .where("reviewTutorID", isEqualTo: "AYsOsdCfLyMQh2uIdX2y")
        .get();

    for (var review in reviews.docs) {
      final newReview = Review(
          reviewerID: review.data()["reviewerID"],
          reviewerStatus: review.data()["reviewerStatus"],
          reviewTutorID: review.data()["reviewTutorID"],
          reviewRating: review.data()["reviewRating"],
          reviewFilter: review.data()["reviewFilter"],
          reviewText: review.data()["reviewText"]);

      reviewList.add(newReview); // add to the list
    } // for loop
    print(reviewList.length);
    print("yelloww");
    return reviewList;
  }
}

// class something{
//
//   static void getReviewsFromDB() async {
//   List<Review> reviewList = [];
//   final reviews = await _db.collection("Reviews").where("reviewTutorID", isEqualTo: "AYsOsdCfLyMQh2uIdX2y").get();
//   for( var review in reviews.docs){
//     final newReview = Review(reviewerID: review.data()["reviewerID"], reviewerStatus: review.data()["reviewerStatus"], reviewTutorID:
//     review.data()["reviewTutorID"], reviewRating: review.data()["reviewRating"],reviewFilter: review.data()["reviewFilter"],reviewText: review.data()["reviewText"]);
//     reviewList.add(newReview); // add to the list
//   }// for loop
//   for(Review review in reviewList) {
//     print(review);
//   }
//
//
//   }// getTutorsFromDB
//   }

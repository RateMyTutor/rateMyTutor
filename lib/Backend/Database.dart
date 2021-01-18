import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rate_my_tutor/Models/Review.dart';
import 'package:rate_my_tutor/Models/Tutor.dart';
import 'package:rate_my_tutor/Models/UserArg.dart';

class Database{

  final db = FirebaseFirestore.instance;


  Future<List<Tutor>> advancedSearchFromDB (String querySubject, String queryCurriculum, String queryClassStatus, String queryLocation) async{

    print(querySubject + " " + queryCurriculum + " " + queryLocation);
    List<Tutor> tutorList = [];
    final tutors = await db.collection("Tutors")
    .where("tutorSubject", isEqualTo: querySubject)
    .where("tutorLocation", isEqualTo: queryLocation)
    .where("tutorCurriculum", isEqualTo: queryCurriculum)
    .get();
    for( var tutor in tutors.docs){
      final newTutor = Tutor(tutorName: tutor.data()["tutorName"], tutorID: tutor.data()["tutorID"], tutorLocation:
      tutor.data()["tutorLocation"], tutorRating: tutor.data()["tutorRating"],tutorSubject: tutor.data()["tutorSubject"], tutorInstituition: tutor.data()['tutorInstituition'],
          tutorCurriculum: tutor.data()['tutorCurriculum']);
      tutorList.add(newTutor); // add to the list
    }// for loop

    return tutorList;

  }// advancedSearchFromDB

  Future<List<Review>> getTutorReviewsFromDB(String tutorID) async {
    List<Review> reviewList = [];
    print(tutorID);
    final reviews = await db
        .collection("Reviews")
        .orderBy('reviewTime')
        .where("reviewTutorID", isEqualTo: tutorID)
        .get();
    for (var review in reviews.docs) {
      DateTime time = review["reviewTime"].toDate();
      print( review["reviewTime"].toDate());


      // DateTime date = time.toDate();
      // print(date);
      final newReview = Review(

          reviewerID: review["reviewerID"],
          reviewerStatus: review["reviewerStatus"],
          reviewTutorID: review["reviewTutorID"],
          reviewRating: review["reviewRating"].toInt(),
          reviewFilter: review["reviewFilter"],
          reviewSubject: review["reviewSubject"],
          reviewTutorName: review["reviewTutorName"],
          reviewText: review["reviewText"],
          reviewerUsername: review["reviewerUsername"],
          reviewTime : review["reviewerID"] == "Anonymous" ? null : review["reviewTime"].toDate()
      );

      reviewList.add(newReview);

    } // for loop
    //print(reviewList);

    return reviewList.reversed.toList();
  }


  Future<List<Review>> getUserReviewsFromDB(String userID) async {
    List<Review> reviewList = [];
    print(userID);
    final reviews = await db
        .collection("Reviews")
        .orderBy('reviewTime')
        .where("reviewerID", isEqualTo: userID)
        .get();
    for (var review in reviews.docs) {
      print("Coming to userReview");
      final newReview = Review(
          reviewerID: review["reviewerID"],
          reviewerStatus: review["reviewerStatus"],
          reviewTutorID: review["reviewTutorID"],
          reviewRating: review["reviewRating"].toInt(),
          reviewFilter: review["reviewFilter"],
          reviewText: review["reviewText"],
          reviewerUsername: review["reviewerUsername"],
          reviewSubject: review["reviewSubject"],
          reviewTutorName: review["reviewTutorName"],
          reviewTime : review["reviewerID"] == "Anonymous" ? null : review["reviewTime"].toDate()
      );
      print(newReview);
      reviewList.add(newReview);

    } // for loop
    print(reviewList);
    return reviewList.reversed.toList();
  }

  Future<List<Tutor>> getTutorsFromDB(String tutorID) async {
    List<Tutor> tutorList = [];
    print(tutorID);
    final tutors = await db
        .collection("Tutors")
        .where("tutorID", isEqualTo: tutorID)
        .get();
    for (var tutor in tutors.docs) {
      final newTutor = Tutor(
          tutorID: tutor["tutorID"],
          tutorName: tutor["tutorName"],
          tutorCurriculum: tutor["tutorCurriculum"],
          tutorSubject: tutor["tutorSubject"].toInt(),
          tutorInstituition: tutor["tutorInstituition"],
          tutorRating: tutor["tutorRating"],
          tutorLocation: tutor["tutorLocation"]);

      tutorList.add(newTutor);

    } // for loop

    return tutorList;
  }

  Future<UserArg> getUserFromDB(String userID) async {
    UserArg newUser;
    print("COMING");

    final users = await db
        .collection("Users")
        .where("userID", isEqualTo: userID)
        .get();
    for (var user in users.docs) {
      print("hello");
      print(user["username"]);
       newUser = UserArg(
          userID: user["userID"],
          username: user["username"]
       );
       print(newUser.username);
    } // for loop
    // print("username");
    // print(newUser.username);
    return newUser;

  }// getUserFromDB

// method checks if the user is logging in for the first time or not
  Future<bool> isFirstLogin(User user) async{

    DocumentSnapshot doc = await  db.collection("Users").doc(user.uid).get();
    if(doc.exists){
      return false;
    }else{
      print("Document doesn't exist, so user is first time logging in");
      return true;
    }
  }// isFirstLogin




}
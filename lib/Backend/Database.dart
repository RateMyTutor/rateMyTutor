import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rate_my_tutor/Models/Review.dart';
import 'package:rate_my_tutor/Models/Tutor.dart';
import 'package:rate_my_tutor/Models/UserArg.dart';

class Database {

  final db = FirebaseFirestore.instance;


  Future<List<Tutor>> advancedSearchFromDB(String querySubject,
      String queryCurriculum, String queryClassStatus,
      String queryLocation) async {
    print(querySubject + " " + queryCurriculum + " " + queryLocation);
    List<Tutor> tutorList = [];

    if (queryLocation == "Any") {
      final tutors = await db.collection("Tutors")
          .where("tutorSubject", isEqualTo: querySubject)
          .where("tutorCurriculum", isEqualTo: queryCurriculum)
          .get();
      for (var tutor in tutors.docs) {
        final newTutor = Tutor(tutorName: tutor.data()["tutorName"],
            tutorID: tutor.data()["tutorID"],
            tutorLocation:
            tutor.data()["tutorLocation"],
            tutorRating: double.parse(tutor.data()["tutorRating"]),
            tutorSubject: tutor.data()["tutorSubject"],
            tutorInstituition: tutor.data()['tutorInstituition'],
            tutorCurriculum: tutor.data()['tutorCurriculum']);
        tutorList.add(newTutor); // add to the list
      } // for loop

      return tutorList;
    } else {
      final tutors = await db.collection("Tutors")
          .where("tutorLocation", arrayContains: queryLocation)
          .where("tutorSubject", isEqualTo: querySubject)
          .where("tutorCurriculum", isEqualTo: queryCurriculum)
          .get();
      for (var tutor in tutors.docs) {
        final newTutor = Tutor(tutorName: tutor.data()["tutorName"],
            tutorID: tutor.data()["tutorID"],
            tutorLocation:
            tutor.data()["tutorLocation"],
            tutorRating: double.parse(tutor.data()["tutorRating"]),
            tutorSubject: tutor.data()["tutorSubject"],
            tutorInstituition: tutor.data()['tutorInstituition'],
            tutorCurriculum: tutor.data()['tutorCurriculum']);
        tutorList.add(newTutor); // add to the list
      } // for loop
    }


    return tutorList;
  } // advancedSearchFromDB

  Future<List<Review>> getTutorReviewsFromDB(String tutorID) async {
    print("Tutor ID =" + tutorID);
    List<Review> reviewList = [];
    final reviews = await db
        .collection("Reviews")
        .orderBy("reviewTime")
        .where("reviewTutorID", isEqualTo: tutorID)
        .get();
    for (var review in reviews.docs) {
      // DateTime time = review["reviewTime"].toDate();
      // print( review["reviewTime"].toDate());
      print(review["reviewerID"]);
      print(review["reviewerStatus"]);
      print(review["reviewTutorID"]);
      print(review["reviewRating"]);
      print(review["reviewFilter"]);
      print(review["reviewSubject"]);
      print(review["reviewTutorName"]);
      print(review["reviewText"]);
      print(review["reviewerUsername"]);
      print(review["reviewTime"]);


      // DateTime date = time.toDate();
      // print(date);
      final newReview = Review(

          reviewerID: review["reviewerID"],
          reviewerStatus: review["reviewerStatus"],
          reviewTutorID: review["reviewTutorID"],
          reviewRating: double.parse(review["reviewRating"]),
          reviewFilter: review["reviewFilter"],
          reviewSubject: review["reviewSubject"],
          reviewTutorName: review["reviewTutorName"],
          reviewText: review["reviewText"],
          reviewerUsername: review["reviewerUsername"],
          reviewTime: review["reviewerID"] == "anonymous"
              ? null
              : review["reviewTime"].toDate()
      );

      reviewList.add(newReview);
    } // for loop
    //print(reviewList);
    print(reviewList);
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
      final newReview = Review(
          reviewerID: review["reviewerID"],
          reviewerStatus: review["reviewerStatus"],
          reviewTutorID: review["reviewTutorID"],
          reviewRating: double.parse(review["reviewRating"]),
          reviewFilter: review["reviewFilter"],
          reviewText: review["reviewText"],
          reviewerUsername: review["reviewerUsername"],
          reviewSubject: review["reviewSubject"],
          reviewTutorName: review["reviewTutorName"],
          reviewTime: review["reviewerID"] == "anonymous"
              ? null
              : review["reviewTime"].toDate()
      );
      print(newReview);
      reviewList.add(newReview);
    } // for loop

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
          tutorSubject: tutor["tutorSubject"],
          tutorInstituition: tutor["tutorInstituition"],
          tutorRating: double.parse(tutor["tutorRating"]),
          tutorLocation: tutor["tutorLocation"]);

      tutorList.add(newTutor);
    } // for loop

    return tutorList;
  }

  Future<UserArg> getUserFromDB(String userID) async {
    UserArg newUser;

    final users = await db
        .collection("Users")
        .where("userID", isEqualTo: userID)
        .get();
    for (var user in users.docs) {
      newUser = UserArg(
          userID: user["userID"],
          username: user["username"]
      );
      print(newUser.username);
    } // for loop
    // print("username");
    // print(newUser.username);
    return newUser;
  } // getUserFromDB

// method checks if the user is logging in for the first time or not
  Future<bool> isFirstLogin(User user) async {
    DocumentSnapshot doc = await db.collection("Users").doc(user.uid).get();
    if (doc.exists) {
      return false;
    } else {
      print("Document doesn't exist, so user is first time logging in");
      return true;
    }
  } // isFirstLogin


  Future<double> getTutorRatingAvg(String tutorID) async {
    double count = 0;
    double sum = 0;
    final reviews = await db
        .collection("Reviews")
        .where("reviewTutorID", isEqualTo: tutorID)
        .get();
    for (var review in reviews.docs) {
      count++;
      sum += review["reviewRating"];
    } // for loop
    return sum/count;
  }

  Future<String> getTutorContact(String tutorID) async {
    String tutorContact = "tel:";
    final tutors = await db
        .collection("Tutors")
        .where("tutorID", isEqualTo: tutorID)
        .get();
    for (var tutor in tutors.docs) {
      tutorContact += tutor["tutorContact"];
    } // for loop
    return tutorContact;
  }

}
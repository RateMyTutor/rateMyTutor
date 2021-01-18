import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rate_my_tutor/Models/Review.dart';
import 'package:rate_my_tutor/Models/Tutor.dart';

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

  Future<List<Review>> getReviewsFromDB(String tutorID) async {
    List<Review> reviewList = [];
    print(tutorID);
    final reviews = await db
        .collection("Reviews")
        .where("reviewTutorID", isEqualTo: tutorID)
        .get();
    for (var review in reviews.docs) {
      final newReview = Review(
          reviewerID: review["reviewerID"],
          reviewerStatus: review["reviewerStatus"],
          reviewTutorID: review["reviewTutorID"],
          reviewRating: review["reviewRating"].toInt(),
          reviewFilter: review["reviewFilter"],
          reviewText: review["reviewText"]);
      print(newReview);
      reviewList.add(newReview);

    } // for loop
    print(reviewList);
    return reviewList;
  }


  Future<List<Review>> getUserReviewsFromDB(String userID) async {
    List<Review> reviewList = [];
    print(userID);
    final reviews = await db
        .collection("Reviews")
        .where("reviewerID", isEqualTo: userID)
        .get();
    for (var review in reviews.docs) {
      final newReview = Review(
          reviewerID: review["reviewerID"],
          reviewerStatus: review["reviewerStatus"],
          reviewTutorID: review["reviewTutorID"],
          reviewRating: review["reviewRating"].toInt(),
          reviewFilter: review["reviewFilter"],
          reviewText: review["reviewText"]);
      print(newReview);
      reviewList.add(newReview);

    } // for loop
    print(reviewList);
    return reviewList;
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



}
import 'package:cloud_firestore/cloud_firestore.dart';
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



}
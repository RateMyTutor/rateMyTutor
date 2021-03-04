import 'package:rate_my_tutor/Backend/Database.dart';

class Tutor{

  String tutorName;
  String tutorID;
  List<dynamic> tutorLocation;
  String tutorSubject;
  double tutorRating;
  String tutorInstituition;
  String tutorCurriculum;
  String tutorBackground;

  Tutor({this.tutorName,this.tutorID,this.tutorLocation,this.tutorRating,this.tutorSubject,this.tutorInstituition,this.tutorCurriculum,this.tutorBackground});

  String getTutorLocation(){
    String location;
    if(this.tutorLocation.length == 1){
      location = this.tutorLocation[0];
    }else{
      location = this.tutorLocation[0];
      for(int i = 1; i < tutorLocation.length; i++){
        location += ", " + this.tutorLocation[i];
      }// for loop
    }// else

    return location;

  }

  String getTutorSubject(){

    return this.tutorSubject;

  }


}// class Tutor
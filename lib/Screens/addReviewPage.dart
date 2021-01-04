import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rate_my_tutor/Models/Tutor.dart';
import 'package:flutter/material.dart';
import 'package:rate_my_tutor/choiceChip.dart';

class AddReviewPage extends StatefulWidget {
  Tutor tutorObject;
  static List list = [];

  AddReviewPage({@required this.tutorObject});
  @override
  _AddReviewPageState createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  final db = FirebaseFirestore.instance;
  int selectedRadio;
  bool checkedValue = false;
  final myController = TextEditingController();
  String curriculum;
  String id;
  int tutorRating;

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    AddReviewPage.list.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tags",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Wrap(
                spacing: 8.0,
                runSpacing: 0.0,
                children: [
                  MyChoiceChip(text: 'Would Recommend'),
                  MyChoiceChip(text: 'Wouldn\'t Recommend'),
                  MyChoiceChip(text: 'Solves lots of examples'),
                  MyChoiceChip(text: 'Great Explanations'),
                  MyChoiceChip(text: 'Eager to help'),
                  MyChoiceChip(text: 'Patient and Kind'),
                ],
              ),
              Text(
                "Curriculum",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              RadioListTile(
                value: 1,
                title: Text('O-Level'),
                groupValue: selectedRadio,
                onChanged: (val) {
                  setSelectedRadio(val);
                  curriculum = 'O-Level';
                },
              ),
              RadioListTile(
                title: Text('A-Level (AS)'),
                value: 2,
                groupValue: selectedRadio,
                onChanged: (val) {
                  setSelectedRadio(val);
                  curriculum = 'A-Level (AS)';
                },
              ),
              RadioListTile(
                title: Text('A-Level (A2)'),
                value: 3,
                groupValue: selectedRadio,
                onChanged: (val) {
                  setSelectedRadio(val);
                  curriculum = 'A-Level (A2)';
                },
              ),
              Text(
                "Rating",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  tutorRating = rating.toInt();
                },
              ),
              Text(
                "Body",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 9,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type your review here',
                    fillColor: Colors.grey[300],
                    filled: true),
                controller: myController,
              ),
              Row(
                children: [
                  Text(
                    'Anonymous',
                    style: TextStyle(fontSize: 16),
                  ),
                  Checkbox(
                    value: checkedValue,
                    onChanged: (value) {
                      setState(() {
                        checkedValue = value;
                        print(value);
                      });
                    },
                  ),
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: FlatButton(
                    color: Colors.blue[200],
                    onPressed: () async {
                      await db.collection("Reviews").add({
                        "reviewText": myController.text,
                        "reviewerStatus": curriculum,
                        "reviewTutorID": widget.tutorObject.tutorID,
                        "reviewerID": userID(),
                        "reviewFilter": AddReviewPage.list[0],
                        "reviewRating" : tutorRating,
                        'createdOn':FieldValue.serverTimestamp(),
                      }).then((value) => Navigator.pop(context));
                    },
                    child: Text('Post review')),
              )
            ],
          ),
        ),
      ),
    ));
  }

  String userID() {
    String id;
    if (checkedValue == true) {
      id = 'Anonymous';
    } else {
      id = 'not anon';
    }
    return id;
  }
}

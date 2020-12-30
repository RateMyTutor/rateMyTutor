import 'package:flutter/material.dart';
import 'package:rate_my_tutor/Models/Tutor.dart';

class DummyScreen extends StatefulWidget {

   Tutor tutorObject;

   DummyScreen({@required this.tutorObject});

  @override
  _DummyScreenState createState() => _DummyScreenState();
}

class _DummyScreenState extends State<DummyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tutorObject.tutorName),
      ),
    );
  }
}

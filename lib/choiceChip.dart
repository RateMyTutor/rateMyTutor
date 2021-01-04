import 'package:flutter/material.dart';
import 'package:rate_my_tutor/Screens/addReviewPage.dart';
class MyChoiceChip extends StatefulWidget {
  String text;

  MyChoiceChip({@required this.text});
  @override
  _MyChoiceChipState createState() => _MyChoiceChipState();
}

class _MyChoiceChipState extends State<MyChoiceChip> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
        selected: isSelected,
        label: Text(widget.text),
        labelStyle: TextStyle(color: Colors.black),
        backgroundColor: Colors.grey[300],
        selectedColor: Colors.blue[300],
        onSelected: (bool selected) {
          if (selected == true) {
            AddReviewPage.list.add(widget.text);
          }
          if (selected == false && AddReviewPage.list.contains(widget.text)) {
            AddReviewPage.list.remove(widget.text);
          }
          setState(() {
            isSelected = selected;
          });
        }
    );

  }

}

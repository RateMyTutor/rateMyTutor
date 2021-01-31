
import 'package:flutter/material.dart';
import 'package:rate_my_tutor/Models/Query.dart';
import 'package:rate_my_tutor/Screens/advancedSearchResults.dart';

class AdvancedSearch extends StatefulWidget {
  static String advancedSearchPageID = "advancedSearchPage";
  @override
  _AdvancedSearchState createState() => _AdvancedSearchState();
}

class _AdvancedSearchState extends State<AdvancedSearch> {
  String location = 'Banani';
  String subject = 'Physics';
  String selectedCurriculum;
  String classStatus = 'Olevels';
  int selectedRadio;

  List curriculum = [
    "Cambridge", "Edexel"
  ];

  List classStatusOptions =  [
    "Olevels", "Alevels (AS)", "Alevels (A2)"
  ];
  List subjectOptions = [
    "Physics", "Math", "Biology", "Chemistry", "Computing Science", "Accounting","Economics", "Business Studies", "Psychology"
  ];

  List locationOptions = [
    'Banani', 'Gulshan 2', 'Bashundhara', 'Gulshan 1', 'Baridhara', 'Uttara', 'Dhanmondi', 'Mohakhali',
    'Mirpur', 'Mohammadpur','Elephant road'
  ];


  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedRadio = -1;
  }

  void setSelectedRadio(int val){
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30.0, 70.0, 30.0, 16.0),
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: formkey,
            child: Column(
              children: [
                Text(
                  "Search",
                  style: TextStyle(
                      fontSize: 36.0,
                      fontFamily: 'Bariol',
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Subject:',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Bariol',
                      color: Colors.black,
                    ),
                  ),
                ),
                DropdownButtonFormField(

                  hint: Text("Select a subject"),
                  dropdownColor: Colors.grey[200],
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 36,
                  isExpanded: true,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22
                  ),
                  value: subject,
                  onChanged: (newValue) {
                    setState((){
                      subject  = newValue;
                    });
                  },
                  items: subjectOptions.map((valueItem){
                    return DropdownMenuItem(
                      value: valueItem,
                      child: Text(valueItem),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Location:',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Bariol',
                      color: Colors.black,
                    ),
                  ),
                ),
                DropdownButtonFormField(

                  hint: Text("Select a location"),
                  dropdownColor: Colors.grey[200],
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 36,
                  isExpanded: true,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22
                  ),
                  value: location,
                  onChanged: (newValue) {
                    setState((){
                      location = newValue;
                    });
                  },
                  items: locationOptions.map((valueItem){
                    return DropdownMenuItem(
                      value: valueItem,
                      child: Text(valueItem),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Class status:',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Bariol',
                      color: Colors.black,
                    ),
                  ),
                ),
                DropdownButtonFormField(
                  hint: Text("Select a class status"),
                  dropdownColor: Colors.grey[200],
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 36,
                  isExpanded:true,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22
                  ),
                  value: classStatus,
                  onChanged: (newValue) {
                    setState((){
                      classStatus  = newValue;
                    });
                  },
                  items: classStatusOptions.map((valueItem){
                    return DropdownMenuItem(
                      value: valueItem,
                      child: Text(valueItem),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Curriculum:',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Bariol',
                      color: Colors.black,
                    ),
                  ),
                ),
                Row(
                  children: [

                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                        Radio(
                          value: 0,
                          groupValue: selectedRadio,
                          activeColor: Colors.blue,
                          onChanged: (val){
                            setSelectedRadio(val);
                            selectedCurriculum = curriculum[selectedRadio];
                            print("Selected Curriculum: " + selectedCurriculum);
                          },
                        ),
                        Text(curriculum[0],style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Bariol',
                          color: Colors.black,
                        ),),
                        Radio(
                          value: 1,
                          groupValue: selectedRadio,
                          activeColor: Colors.blue,
                          onChanged: (val){
                            setSelectedRadio(val);
                            selectedCurriculum = curriculum[selectedRadio];
                            print("Selected Curriculum: " + selectedCurriculum);
                          },
                        ),
                        Text(curriculum[1],style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Bariol',
                          color: Colors.black,
                        ),),


                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 34.0,
                ),
                ButtonTheme(
                  minWidth: 245,
                  height: 53,
                  child: FlatButton(
                    color: Color(0xff583CDF),
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(26.5)),
                    onPressed: () async {
                      //create new Query object
                      Query query = Query(queryLocation: location, queryClassStatus: classStatus,
                          queryCurriculum: selectedCurriculum,querySubject: subject);

                      //now push to the search results page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdvancedSearchResults(queryObject: query),
                        ),
                      );
                    },


                    child: Text(
                      'Search',
                      style: TextStyle(
                        color: Color(0xFFF2F2F2),
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      ));
  }//build

  void validate() async {
    // if(formkey.currentState.validate()){
    //   await addUserToDb(uAuth.currentUser);
    //   Navigator.pushNamed(context, HomePage.homePageID);
    // }else{
    //   print("Failed validation");
    // }
  }
}

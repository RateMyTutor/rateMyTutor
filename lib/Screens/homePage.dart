
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rate_my_tutor/Backend/Database.dart';
import 'package:rate_my_tutor/Models/Tutor.dart';
import 'package:rate_my_tutor/Screens/advancedSearch.dart';
import 'package:rate_my_tutor/Screens/initialScreen.dart';
import 'package:rate_my_tutor/Screens/loginPage.dart';
import 'package:rate_my_tutor/Models/Tutor.dart';
import 'package:rate_my_tutor/Screens/tutorSearch.dart';
import 'package:rate_my_tutor/auth_service.dart';
import 'package:sizer/sizer.dart';
import 'package:rate_my_tutor/Screens/tutorPage.dart';




class HomePage extends StatefulWidget {

  static String homePageID = "homePage";
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  int selectedIndex = 0;
  final FirebaseAuth uAuth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  ScrollController _scrollController = new ScrollController();
  SearchBar searchBar;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff583CDF),
          automaticallyImplyLeading: false,
          // backgroundColor: Color(0xFF3DDCFA),
          // actions: <Widget>[
          //   IconButton(
          //       icon: Icon(Icons.search),
          //       onPressed: (){
          //         showSearch(context: context, delegate: TutorSearch()).then((value) =>  setState((){}));
          //
          //
          //       },
          //   ),
          // ],
          // title: Text(
          //     'TutorQuest',
          //   style: TextStyle(
          //     fontSize: 25.0,
          //     fontWeight: FontWeight.bold,
          //     fontFamily: 'Bariol',
          //     color: Colors.black,
          //   ),
          // ),
          title: Container(
            child: TextField(
              focusNode: FocusNode(),
              enableInteractiveSelection: false,
              onTap: (){
                      showSearch(context: context, delegate: TutorSearch()).then((value) =>  setState((){}));


                    },


              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 9.0),
                  filled: true,
                  fillColor: Color(0xFFe7eaf0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                    borderRadius: BorderRadius.all(
                      const Radius.circular(21.0),
                    ),
                  ),
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search)
              ),
            ),
          ),
      // leading: IconButton(
      // icon: Icon(Icons.logout),
      // onPressed: () async {
      //   uAuth.signOut();
      //   Navigator.pushNamed(context,InitialScreen.initialScreenID);
      //   print("USer ID : " + uAuth.currentUser.uid);
      //   print("Lets see if we can still see it ");
      //   print(uAuth.currentUser.displayName);
      //   }, //onPressed
      // ),
        ),
        body: SingleChildScrollView(
                controller: _scrollController,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 40.0, right: 16.0),
                  child:Column(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                                "Welcome",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Bariol',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.0.sp,
                                )
                            ),
                          ),
                          FutureBuilder(
                            future: Database().getUserFromDB(uAuth.currentUser.uid),
                              builder: (context, snapshot) {
                              return displayUsername(context,snapshot);
                              }),
                          SizedBox(
                            height: 2.0.h,
                          ),
                          ButtonTheme(
                            padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0), //adds padding inside the button
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, //limits the touch area to the button area
                            minWidth: 0, //wraps child's width
                            height: 0, //wraps child's height
                            child: FlatButton(
                              color: Color(0xFFcfd2d8),
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(
                                      26.5)),
                              onPressed: () async {},
                              child: Text(
                                  "edit profile",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Bariol',
                                    fontSize: 12.0.sp,
                                  )
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 6.0.h,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 2.0.w),
                              child: Text(
                                "Reviews Made By You: ",
                                style: TextStyle(
                                  fontSize: 16.0.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Bariol',
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.grey[500],
                            thickness: 0.5.h,
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Container(
                            child: FutureBuilder(
                                future: Database().getUserReviewsFromDB(
                                    uAuth.currentUser.uid),
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
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      snapshot.data[index].reviewTutorName,
                                                      style: TextStyle(
                                                        fontSize: 15.0.sp,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: 'Bariol',
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text('5.0',//snapshot.data[index].reviewRating.toString()
                                                          style: TextStyle(
                                                            fontSize: 15.0.sp,
                                                            fontFamily: 'Bariol',
                                                            fontWeight: FontWeight.bold,

                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 10,right: 8),
                                                          child: Text('/5',
                                                            style: TextStyle(
                                                              fontFamily: 'Bariol',
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    // Container(
                                                    //   color:snapshot.data[index].reviewerUsername == "Anonymous" ? Colors.purple[50]: Colors.white,
                                                    //   child: Text(
                                                    //     snapshot.data[index].reviewerUsername == "Anonymous" ? snapshot.data[index].reviewerUsername : "",
                                                    //       style: TextStyle(
                                                    //         color: Colors.black,
                                                    //           fontSize: 18)),
                                                    // ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                        snapshot.data[index].reviewSubject,
                                                      style: TextStyle(
                                                          fontFamily: 'Bariol',
                                                          fontSize: 12.0.sp,
                                                          fontWeight: FontWeight.bold
                                                      ),
                                                    ),
                                                    // Row(
                                                    //   children: [
                                                    //     Padding(
                                                    //       padding: const EdgeInsets.only(right:8.0),
                                                    //       child: Text(
                                                    //         "${TutorPage.formatDate(snapshot.data[index].reviewTime.day, snapshot.data[index].reviewTime.month, snapshot.data[index].reviewTime.year)}",
                                                    //         style: TextStyle(
                                                    //             fontFamily: 'Bariol',
                                                    //             fontSize: 16,
                                                    //             fontStyle: FontStyle.italic
                                                    //         ),
                                                    //       ),
                                                    //     ),
                                                    //   ],
                                                    // ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  truncateText(
                                                      snapshot.data[index]
                                                          .reviewText),
                                                  style: TextStyle(
                                                    fontSize: 15.0.sp,
                                                    fontFamily: 'Bariol',
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: Color(0x26583CDF),
                                                        borderRadius: BorderRadius.all(Radius.circular(20)

                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(4.0),
                                                        child: Text(
                                                            snapshot
                                                                .data[index].reviewFilter,
                                                            style: TextStyle(fontSize: 12.0.sp,fontFamily: 'Bariol',)),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                SizedBox(
                                                  height: 4,
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(uAuth.currentUser.displayName);
    print(uAuth.currentUser.providerData);
    getUsername();
  }


  
  void getUsername() async{

    return await db.collection("Users").doc(uAuth.currentUser.uid).get().then((value){
      print(value.data());
    });
  }
}

String truncateText(String text) {
  int cutoff = 170;
  return (text.length <= cutoff)
      ? text
      : '${text.substring(0, cutoff)}...';
}


Widget displayUsername(BuildContext context, AsyncSnapshot snapshot) {
  if (snapshot.data == null) {
    return Center(
      child: Text(
      "",
      style: TextStyle(
        color: Colors.white,
      ),
      ),
    );
  } else {
    return Text(
        snapshot.data.username,
        maxLines: 1,
        style: TextStyle(
          fontFamily: 'Bariol',
          fontWeight: FontWeight.bold,
          fontSize: 25.0.sp,
        )
    );
  }
}

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
          centerTitle: true,
          backgroundColor: Color(0xFF3DDCFA),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: (){
                  showSearch(context: context, delegate: TutorSearch()).then((value) =>  setState((){}));


                },
            ),
          ],
          title: Text(
              'TutorQuest',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Bariol',
              color: Colors.black,
            ),
          ),
      leading: IconButton(
      icon: Icon(Icons.logout),
      onPressed: () async {
        uAuth.signOut();
        Navigator.pushNamed(context,InitialScreen.initialScreenID);
        print("USer ID : " + uAuth.currentUser.uid);
        print("Lets see if we can still see it ");
        print(uAuth.currentUser.displayName);
        }, //onPressed
      ),
        ),
        body: SingleChildScrollView(
                controller: _scrollController,
                child: Padding(
                  padding: EdgeInsets.only(top: 4.0.h),
                  child:Column(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                                "Welcome,",
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
                            minWidth: 10.0.w,
                            height: 6.0.h,
                            child: FlatButton(
                              color: Color(0xFF4DAADD),
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(
                                      26.5)),
                              onPressed: () async {},
                              child: Text(
                                'Edit Profile',
                                style: TextStyle(
                                  color: Color(0xFFF2F2F2),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                ),
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
                                                  children: [
                                                    Text(
                                                      snapshot.data[index].reviewTutorName,
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Container(
                                                      color: Colors.blue[50],
                                                      child: Text(
                                                          snapshot.data[index].reviewSubject,
                                                          style: TextStyle(
                                                              fontSize: 18)),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Container(
                                                      color:snapshot.data[index].reviewerUsername == "Anonymous" ? Colors.purple[50]: Colors.white,
                                                      child: Text(
                                                        snapshot.data[index].reviewerUsername == "Anonymous" ? snapshot.data[index].reviewerUsername : "",
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                              fontSize: 18)),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                FittedBox(
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Rating: ' +
                                                            snapshot.data[index]
                                                                .reviewRating
                                                                .toString() +
                                                            '/5',
                                                        style: TextStyle(
                                                            fontSize: 18
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 6,
                                                      ),
                                                      Container(
                                                        color: Colors.pink[50],
                                                        child: Text(
                                                            snapshot
                                                                .data[index]
                                                                .reviewFilter,
                                                            style: TextStyle(
                                                                fontSize: 16)),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                  truncateText(
                                                      snapshot.data[index]
                                                          .reviewText),
                                                  style: TextStyle(
                                                      fontSize: 16),
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
      child: Container(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(),
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
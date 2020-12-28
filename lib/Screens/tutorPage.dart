import 'package:flutter/material.dart';
class TutorPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 16.0,top: 40.0,right: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Smriti Dhiman',
                  style: TextStyle(
                      fontSize: 24
                  ),
                ),
                Text(
                  'Rating: ',
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
                Text(
                  'Ex-math teacher at Scholastica',
                  style: TextStyle(
                      fontSize: 20
                  ),),
                Text('MATH',
                  style: TextStyle( fontSize: 20),),
                Text(
                    'Location: Academia (Gulshan)',
                    style: TextStyle(
                        fontSize: 20
                    )
                ),
                SizedBox(height: 30,),
                Text(
                  'Reviews',
                  style: TextStyle(
                      fontSize: 24
                  ),
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: (context,index){
                      return Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Saadman13', style: TextStyle(fontSize: 20),
                            ),
                            Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
                                'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
                                ' Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      );
                    }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
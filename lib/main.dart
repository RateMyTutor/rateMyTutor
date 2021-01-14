
import 'package:provider/provider.dart';
import 'package:rate_my_tutor/Screens/advancedSearch.dart';
import 'package:rate_my_tutor/Screens/initialScreen.dart';

import 'Screens/homePage.dart';
import 'Screens/loginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'Screens/signUpPage.dart';
import 'Screens/firstTimeLogin.dart';
import 'Utilities/bottomNavBar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth_bloc.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(Setup());
}

class Setup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder( //return LayoutBuilder
        builder: (context, constraints) {
          return OrientationBuilder( //return OrientationBuilder
              builder: (context, orientation) {
                //initialize SizerUtil()
                SizerUtil().init(constraints, orientation);
                return Provider(
                  create: (context) => AuthBloc(),
                  child: MaterialApp(
                    initialRoute: InitialScreen.initialScreenID,
                    routes: {
                      InitialScreen.initialScreenID: (context) =>
                          InitialScreen(),
                      LoginPage.loginPageID: (context) => LoginPage(),
                      SignUpPage.signUpPageID: (context) => SignUpPage(),
                      HomePage.homePageID: (context) => HomePage(),
                      FirstTimeLogin.firstTimeLoginPage: (context) =>
                          FirstTimeLogin(),
                      AdvancedSearch.advancedSearchPageID: (context) =>
                          AdvancedSearch(),
                      BottomNavBar.bottomNavBarID: (context) => BottomNavBar(),
                    },
                  ),
                );
              }
          );
        }
    );
  }
}



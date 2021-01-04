
import 'package:provider/provider.dart';
import 'package:rate_my_tutor/Screens/advancedSearch.dart';

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






void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(Setup());
}

class Setup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        initialRoute: LoginPage.loginPageID,
        routes: {
          LoginPage.loginPageID : (context) => LoginPage(),
          SignUpPage.signUpPageID : (context) => SignUpPage(),
          HomePage.homePageID : (context) => HomePage(),
          FirstTimeLogin.firstTimeLoginPage : (context) => FirstTimeLogin(),
          AdvancedSearch.advancedSearchPageID : (context) => AdvancedSearch(),
          BottomNavBar.bottomNavBarID : (context) => BottomNavBar(),
        },
      ),
    );
  }
}



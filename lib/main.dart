
import 'Screens/homePage.dart';
import 'Screens/loginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'Screens/signUpPage.dart';
import 'package:firebase_core/firebase_core.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(Setup());
}

class Setup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginPage.loginPageID,
      routes: {
        LoginPage.loginPageID : (context) => LoginPage(),
        SignUpPage.signUpPageID : (context) => SignUpPage(),
        HomePage.homePageID : (context) => HomePage(),
      },
    );
  }
}



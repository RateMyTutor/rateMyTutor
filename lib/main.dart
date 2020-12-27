

import 'loginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


void main() {
  runApp(Setup());
}

class Setup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginPage.loginPageID,
      routes: {
        LoginPage.loginPageID : (context) => LoginPage(),
        //SignUpPage.signUpPageID : context => SignUpPage(),
      },
    );
  }
}



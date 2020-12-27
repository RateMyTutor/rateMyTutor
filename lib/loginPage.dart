
import 'package:flutter/material.dart';
class LoginPage extends StatefulWidget {
  static String loginPageID = "LoginPage";
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 100.0, horizontal: 60.0),
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.brown.shade800,
                    child: Text(
                        'APP'
                    ),
                  ),
                ),
              ),
              Text(
                'Email Address',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email Address',
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Password',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                obscureText: hidePassword,
                decoration: InputDecoration(
                    suffix: InkWell(
                      onTap: (){
                        setState(() {
                          hidePassword = hidePassword == true ? false : true;
                        });
                      },
                      child: Icon(Icons.visibility),
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Password'
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    onPressed: (){
                      //TODO: Go to home page
                    },
                    color: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text("Login"),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  RaisedButton(
                    onPressed: (){
                      //TODO: Go to SignUp Page
                     // Navigator.pushNamed(context, SignUpPage.signUpPageID);
                    },
                    color: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text("Sign Up"),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
    );
  }
}



import 'dart:async';

import 'package:busz/authentication/sign-up.dart';
import 'package:busz/pages/homescreen.dart';
import 'package:busz/pages/selection.dart';
import 'package:busz/pages/start.dart';
import 'package:busz/splash/splash1.dart';
import 'package:busz/uploader/upload.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:transition/transition.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email = "";
  String password = "";
  FirebaseAuth auth = FirebaseAuth.instance;
  bool selected = false;
  Icon eye = Icon(Icons.visibility_off);
  List array = [
    'https://img.freepik.com/free-vector/passengers-waiting-bus-city-queue-town-road-flat-vector-illustration-public-transport-urban-lifestyle_74855-8493.jpg?w=996&t=st=1671139299~exp=1671139899~hmac=a33a599997a470610808908223ac288b10c0a68bb93e0007bafca0ca6fef5d56',
    'https://img.freepik.com/free-vector/mother-meeting-her-son-from-summer-vacation_74855-10962.jpg?w=996&t=st=1671139355~exp=1671139955~hmac=e032d75c992a01c67e51babe27d8623cb88e005132108517070a58a2d1b3d6a7',
  ];
  int counter1 = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      email = '';
      password = '';
    });
    Timer.periodic(Duration(seconds: 2), (timer) {
      if (mounted)
        setState(() {
          if (counter1 < 100) {
            counter1 += 1;
          } else {
            counter1 = 0;
          }
        });
    });
  }

  myselection() {
    selected = !selected;
    if (selected == true) {
      setState(() {
        eye = Icon(Icons.visibility);
      });
    } else if (selected == false) {
      setState(() {
        eye = Icon(Icons.visibility_off);
      });
    }
  }

  Widget Mywidget() {
    return (counter1 % 2 == 0)
        ? Image.network(
            array[1],
            fit: BoxFit.cover,
            height: 200,
            width: 250,
          )
        : Image.network(
            array[0],
            fit: BoxFit.cover,
            height: 200,
            width: 250,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "UTHAVI's",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff975C8D),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff975C8D),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Login to your account",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  )
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 20)),
              Container(
                child: Mywidget(),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Email',
                  ),
                  onChanged: (value) {
                    setState(() {
                      email = value.trim();
                    });
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: TextField(
                    obscureText: !selected,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                          onPressed: () {
                            myselection();
                          },
                          icon: eye),
                      hintText: 'Password',
                    ),
                    onChanged: (value) {
                      setState(() {
                        password = value.trim();
                      });
                    },
                  )),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: MaterialButton(
                        height: 60,
                        minWidth: 200,
                        child: Text(
                          "SIGN-IN",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        color: Color(0xff975C8D),
                        splashColor: Color(0xffD989B5),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        onPressed: () async {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: email, password: password)
                              .then((_) =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SplashScreen(),
                                  )));
                        }),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: 16),
                  ),
                  MaterialButton(
                    splashColor: Colors.white,
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          Transition(
                              child: SignUp(),
                              transitionEffect:
                                  TransitionEffect.LEFT_TO_RIGHT));
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void dis1(
    BuildContext context,
    String error,
  ) {
    var alertDialog = AlertDialog(
        title: Text(
          'ERROR!',
          style: TextStyle(
              color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        content: Text(error),
        actions: [
          FlatButton(
            onPressed: () {},
            child: Text(
              'OK',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          )
        ]);
    showDialog(
        context: context,
        barrierDismissible: true,
        barrierColor: Colors.transparent,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}

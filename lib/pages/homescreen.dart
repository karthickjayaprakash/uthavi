import 'dart:async';

import 'package:busz/authentication/sign-in.dart';
import 'package:busz/history/history1.dart';
import 'package:busz/pages/aboutapp.dart';
import 'package:busz/pages/start.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:transition/transition.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Color c1 = Color(0xff975C8D);
  int counter1 = 0;
  var array = [
    'assets/t1.jfif',
    'assets/t2.jfif',
    'assets/t3.jfif',
    'assets/t4.jfif',
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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

  Widget Mywidget() {
    var x = counter1 % 4;
    var value;
    if (x == 0) {
      setState(() {
        value = array[0];
      });
    } else if (x == 1) {
      setState(() {
        value = array[1];
      });
    } else if (x == 2) {
      setState(() {
        value = array[2];
      });
    } else if (x == 3) {
      setState(() {
        value = array[3];
      });
    }
    return Image.asset(value, fit: BoxFit.cover, height: 220, width: 370);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(100, 80),
          child: SafeArea(
            child: Container(
              height: 50,
              color: Colors.transparent,
            ),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Center(
                child: Container(
                    child: Image.asset(
                  'assets/home.png',
                  width: 250,
                  fit: BoxFit.contain,
                )),
              ),
              SizedBox(
                height: 20,
              ),
              Mywidget(),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: GestureDetector(
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                Transition(
                                    child: StartPage(),
                                    transitionEffect:
                                        TransitionEffect.RIGHT_TO_LEFT));
                          },
                          splashColor: Colors.black,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 100,
                                  child: Image.asset('assets/scan.png'),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Scanner',
                                  style: TextStyle(
                                      color: c1,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: GestureDetector(
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                Transition(
                                    child: History1(),
                                    transitionEffect:
                                        TransitionEffect.RIGHT_TO_LEFT));
                          },
                          splashColor: Colors.black,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 100,
                                  child: Image.asset('assets/history.png'),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'History',
                                  style: TextStyle(
                                      color: c1,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: GestureDetector(
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                Transition(
                                    child: Aboutapp(),
                                    transitionEffect:
                                        TransitionEffect.RIGHT_TO_LEFT));
                          },
                          splashColor: Colors.black,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 100,
                                  child: Image.asset('assets/properties.png'),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'About App',
                                  style: TextStyle(
                                      color: c1,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: GestureDetector(
                        child: InkWell(
                          onTap: () {
                            FirebaseAuth.instance.signOut().then((value) => {
                                  Navigator.pushReplacement(
                                      context,
                                      Transition(
                                          child: SignIn(),
                                          transitionEffect:
                                              TransitionEffect.FADE))
                                });
                          },
                          splashColor: Colors.black,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 100,
                                  child: Image.asset('assets/logout.png'),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Log out',
                                  style: TextStyle(
                                      color: c1,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

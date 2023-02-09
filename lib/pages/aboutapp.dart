import 'package:busz/pages/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:transition/transition.dart';

class Aboutapp extends StatefulWidget {
  const Aboutapp({Key? key}) : super(key: key);

  @override
  State<Aboutapp> createState() => _AboutappState();
}

class _AboutappState extends State<Aboutapp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(100, 80),
        child: SafeArea(
          child: Container(
            height: 60,
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          Transition(
                              child: Home(),
                              transitionEffect:
                                  TransitionEffect.LEFT_TO_RIGHT));
                    },
                    icon: Icon(
                      Icons.navigate_before,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Center(
                child: Container(
                    child: Image.asset(
                  'assets/about.png',
                  width: 250,
                  fit: BoxFit.contain,
                )),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Container(
                    width: 200,
                    height: 250,
                    child: Image.asset(
                      'assets/logo.png',
                      fit: BoxFit.contain,
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Features:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Placer("EASY TO ACCESS"),
                  Placer("AUTHENTICATION VERFICATION"),
                  Placer("IMAGE WITH TAMIL TEXT IS CONVERTED TO ENGLISH"),
                  Placer("HISTORY OF PREVIOUS TRANSLATIONS"),
                  Placer("SHARING OF TRANSLATED TEXT"),
                  Placer("SHORT SUMMARY OF PLACE SCANNED"),
                  Placer("EMPTY OR BLURRED IMAGE IS IDENTIFIED"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget Placer(var value) {
    return Column(
      children: [
        Text(
          '⚫\t\t' + value,
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}

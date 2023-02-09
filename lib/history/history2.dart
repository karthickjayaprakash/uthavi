import 'package:busz/pages/selector1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:transition/transition.dart';

class History2 extends StatefulWidget {
  String filename;
  History2({required this.filename});
  @override
  State<History2> createState() => _History2State();
}

class Model {
  String time;
  String image;
  String date;
  Model({required this.image, required this.date, required this.time});
}

class _History2State extends State<History2> {
  var email;
  List<Model> trialmodel = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email = FirebaseAuth.instance.currentUser!.email;
    FirebaseFirestore.instance
        .collection('history')
        .doc(email)
        .collection(widget.filename)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        Model ox = Model(
            image: element['image'],
            date: element['date'],
            time: element['time']);
        setState(() {
          trialmodel.add(ox);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.filename,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_sharp,
            color: Colors.black,
            size: 25,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Expanded(
                child: ListView.builder(
              itemCount: trialmodel.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: (index % 2 == 0)
                            ? LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                    Colors.white,
                                    Color.fromARGB(255, 194, 255, 172)
                                  ])
                            : LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                    Color.fromARGB(255, 255, 170, 241),
                                    Colors.white
                                  ])),
                    child: GestureDetector(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              Transition(
                                  child: selector1(
                                    imageurl: trialmodel[index].image,
                                  ),
                                  transitionEffect:
                                      TransitionEffect.RIGHT_TO_LEFT));
                        },
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  height: 150,
                                  width: 150,
                                  child: Image.network(
                                    trialmodel[index].image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                    child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: <Widget>[
                                        Icon(Icons.output),
                                        Text(
                                          ':',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Container(
                                          child: Padding(
                                            padding: EdgeInsets.all(0),
                                            child: Text(
                                              trialmodel[index].date,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Icon(Icons.timeline),
                                        Text(
                                          ':',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          trialmodel[index].time,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}

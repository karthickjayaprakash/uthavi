import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:transition/transition.dart';

import '../pages/homescreen.dart';
import 'history2.dart';

class History1 extends StatefulWidget {
  const History1({Key? key}) : super(key: key);

  @override
  State<History1> createState() => _History1State();
}

class _History1State extends State<History1> {
  List myarray = [];
  var email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email = FirebaseAuth.instance.currentUser!.email;
    FirebaseFirestore.instance
        .collection('history')
        .doc(email)
        .get()
        .then((value) {
      if (value.exists) {
        setState(() {
          myarray = value.data()?['list'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
                context,
                Transition(
                    child: Home(),
                    transitionEffect: TransitionEffect.LEFT_TO_RIGHT));
          },
          child: Icon(
            Icons.arrow_back_sharp,
            color: Colors.black,
            size: 25,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.white, Colors.white],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/history1.png',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.only(left: 20, top: 20),
              child: Text('DATEWISE:',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          Expanded(
            child: (myarray.isEmpty)
                ? Container(child: Center(child: CircularProgressIndicator()))
                : Container(
                    child: ListView.builder(
                      itemCount: myarray.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          print(myarray[index]);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => History2(
                                        filename: myarray[index],
                                      )));
                        },
                        child: Container(
                          child: Material(
                            color: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Divider(
                                    thickness: 2,
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.folder,
                                      color: Color(0xfffccc77),
                                    ),
                                    title: Text(myarray[index]),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Divider(
                                    thickness: 2,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          )
        ]),
      ),
    );
  }
}

import 'dart:io';
import 'package:busz/pages/start.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:transition/transition.dart';
import 'package:wikidart/wikidart.dart';

import '../uploader/upload.dart';

class selection extends StatefulWidget {
  XFile image;
  selection({required this.image});
  @override
  State<selection> createState() => _selectionState();
}

class _selectionState extends State<selection> {
  var attacher;
  var response;
  var urlDownload;
  var arrayupdate = [];
  var email;
  var districtinfo;
  Color c1 = Color(0xff975C8D);
  @override
  void initState() {
    email = FirebaseAuth.instance.currentUser!.email;
    sender(widget.image);
    super.initState();
  }

  sender(var image) async {
    var date = DateTime.now().toString().substring(0, 10);
    File s = File(image.path);
    final time = DateTime.now().hour.toString() +
        'hr-' +
        DateTime.now().minute.toString() +
        'min-' +
        DateTime.now().second.toString() +
        'sec';
    final destination = 'history/$email/$date/$time';
    var task = Upload.uploadFile(destination, s);
    if (task == null) {
      return;
    } else {
      final snapshot = await task.whenComplete(() {});
      urlDownload = await snapshot.ref.getDownloadURL();
      attacher = "http://10.0.2.2:5000/service?url=" +
          Uri.encodeComponent(urlDownload);
      setState(() {
        attacher = Uri.parse(attacher);
      });
      FirebaseFirestore.instance
          .collection('history')
          .doc(email)
          .get()
          .then((value) {
        setState(() {
          arrayupdate = value.data()?['list'];
          if (!arrayupdate.contains(date)) {
            setState(() {
              arrayupdate.add(date);
              FirebaseFirestore.instance
                  .collection('history')
                  .doc(email)
                  .update({
                'list': arrayupdate,
              });
            });
          }
        });
      });

      FirebaseFirestore.instance
          .collection('history')
          .doc(email)
          .collection(date)
          .doc(time.toString())
          .set({
        'image': urlDownload,
        'time': time.toString(),
        'date': date.toString(),
      });
    }
  }

  Future<void> finder(String district) async {
    var res = await Wikidart.searchQuery(district + ' district');
    var pageid = res?.results?.first.pageId;

    if (pageid != null) {
      districtinfo = await Wikidart.summary(pageid);
      setState(() {
        districtinfo = districtinfo;
      });
    }
  }

  Future<void> setter1() async {
    response = await http
        .get(
          attacher,
        )
        .whenComplete(() => {
              setState(() {}),
            });
    setState(() {
      if (response.body.toString() == 'null') {
        dis1(context,
            'Invalid Image has been taken, So please Retake the Image!!');
      }
    });
  }

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
                              child: StartPage(),
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
        child: Column(
          children: <Widget>[
            Center(
              child: Container(
                  child: Image.asset(
                'assets/viewer.png',
                width: 250,
                fit: BoxFit.contain,
              )),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Image Captured:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 250,
              width: 300,
              child: Image.file(
                File(widget.image.path),
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: GestureDetector(
                child: InkWell(
                  onTap: () {
                    setter1();
                  },
                  splashColor: Colors.black,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 80,
                          child: Image.asset('assets/translate.png'),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'TRANSLATE',
                          style: TextStyle(
                              color: c1,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            (response != null && response.body != 'null')
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "Place name is:",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            child: Text(
                              '${response.body}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: GestureDetector(
                              child: InkWell(
                                onTap: () {
                                  Share.share(response.body.toString());
                                },
                                splashColor: Colors.black,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 60,
                                        child: Image.asset('assets/share.png'),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'SHARE',
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
                                  finder(response.body.toString());
                                },
                                splashColor: Colors.black,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 60,
                                        child: Image.asset('assets/search.png'),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'SEARCH FOR INFO',
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
                      SizedBox(
                        height: 30,
                      ),
                      if (districtinfo != null)
                        Text(
                          'Summarized Information:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      SizedBox(
                        height: 20,
                      ),
                      if (districtinfo != null)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Title:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(child: Text(districtinfo.title))
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Description:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Expanded(
                                      child: Text(districtinfo.description))
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Summary:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Expanded(child: Text(districtinfo.extract))
                                ],
                              ),
                            ],
                          ),
                        )
                    ],
                  )
                : Container(),
            SizedBox(
              height: 30,
            ),
          ],
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
          'Error!',
          style: TextStyle(
              color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        content: Text(error),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  Transition(
                      child: StartPage(),
                      transitionEffect: TransitionEffect.LEFT_TO_RIGHT));
            },
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

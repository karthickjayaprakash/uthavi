import 'package:busz/pages/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:busz/pages/selection.dart';
import 'package:busz/uploader/upload.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:transition/transition.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  var _image;
  var arrayupdate = [];
  Color c1 = Color(0xff975C8D);

  Future getimage(bool cameraon) async {
    XFile image;
    final picture = ImagePicker();
    if (cameraon) {
      image = (await picture.pickImage(source: ImageSource.camera))!;
    } else {
      image = (await picture.pickImage(source: ImageSource.gallery))!;
    }
    setState(() {
      _image = image;
    });
    if (_image != null) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => selection(image: _image)));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Center(
            child: Container(
                child: Image.asset(
              'assets/scanner.png',
              width: 300,
              fit: BoxFit.contain,
            )),
          ),
          SizedBox(
            height: 40,
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  child: Image.asset('assets/scan.png'),
                ),
              ]),
          SizedBox(
            height: 60,
          ),
          Text(
            'Select any of the below two modes to Scan:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          SizedBox(
            height: 40,
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
                        getimage(false);
                      },
                      splashColor: Colors.black,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 100,
                              child: Image.asset('assets/gallery.png'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'GALLERY',
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
                        getimage(true);
                      },
                      splashColor: Colors.black,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 100,
                              child: Image.asset('assets/camera.png'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'CAMERA',
                              style: TextStyle(
                                  color: c1,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

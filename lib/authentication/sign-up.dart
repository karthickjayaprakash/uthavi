import 'package:busz/authentication/sign-in.dart';
import 'package:busz/pages/start.dart';
import 'package:busz/splash/splash1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:transition/transition.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = "";
  String password = "";
  String repassword = "";
  FirebaseAuth auth = FirebaseAuth.instance;
  bool selected = false;
  Icon eye = Icon(Icons.visibility_off);
  bool selected1 = false;
  Icon eye1 = Icon(Icons.visibility_off);
  int counter1 = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      email = '';
      password = '';
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

  myselection1() {
    selected1 = !selected1;
    if (selected1 == true) {
      setState(() {
        eye1 = Icon(Icons.visibility);
      });
    } else if (selected == false) {
      setState(() {
        eye1 = Icon(Icons.visibility_off);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                Transition(
                    child: SignIn(),
                    transitionEffect: TransitionEffect.LEFT_TO_RIGHT));
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 25,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
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
                    "Sign Up",
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
                    "Sign Up to register account",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  )
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 20)),
              Image.network(
                "https://img.freepik.com/premium-vector/register-now-isolated-icon-banner-yellow-megaphone-speech-bubble-abstract-elements-trendy-style-registration-button-ui-design-element-web-site-subscribe-membership-vector-illustration_87771-11532.jpg?w=826",
                fit: BoxFit.cover,
                height: 150,
                width: 250,
              ),
              SizedBox(
                height: 30,
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
                height: 15,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: TextField(
                    obscureText: !selected1,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                          onPressed: () {
                            myselection1();
                          },
                          icon: eye1),
                      hintText: 'ReEnter Password',
                    ),
                    onChanged: (value) {
                      setState(() {
                        repassword = value.trim();
                      });
                    },
                  )),
              Padding(padding: EdgeInsets.only(top: 35)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: MaterialButton(
                        height: 60,
                        minWidth: 200,
                        child: Text(
                          "REGISTER",
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
                          if (password == repassword) {
                            FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: email, password: password)
                                .then((_) => FirebaseFirestore.instance
                                        .collection('history')
                                        .doc(email)
                                        .set({
                                      'id': email,
                                      'list': [],
                                    }).then((value) => Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  SplashScreen(),
                                            ))));
                          } else {
                            dis1(context,
                                "Password And Repassword are not same");
                          }
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
                    "Already have an account?",
                    style: TextStyle(fontSize: 16),
                  ),
                  MaterialButton(
                    splashColor: Colors.white,
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          Transition(
                              child: SignIn(),
                              transitionEffect:
                                  TransitionEffect.LEFT_TO_RIGHT));
                    },
                    child: Text(
                      'Sign In',
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
            onPressed: () {
              Navigator.pop(context);
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

  void dis2(
    BuildContext context,
    String msg,
  ) {
    var alertDialog = AlertDialog(
        title: Text(
          'Successful',
          style: TextStyle(
              color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        content: Text(msg),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                email = "";
                password = "";
                repassword = "";
              });
            },
            child: Text(
              'OK',
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
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

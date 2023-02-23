import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopnest/rider%20side/MainMenuScreen.dart';

import 'Screens/MainDisplayScreen.dart';
import 'Screens/SigninScreem.dart';
import 'Screens/SignupScreen.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  _MainMenuScreenState createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  final mauth = FirebaseAuth.instance;
  bool ontabsignin = false;
  bool ontabsignup = false;
  bool ontabskip = false;

  Widget skipbutton(
      String textofbutton, Color color_of_button, Color color_of_text) {
    return AnimatedContainer(
      duration: Duration(microseconds: 200),
      height: ontabskip ? 47 : 60,
      width: ontabskip
          ? MediaQuery.of(context).size.width / 1.8
          : MediaQuery.of(context).size.width / 1.5,
      decoration: BoxDecoration(
          color: color_of_button,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.black)),
      child: Center(
        child: Text(
          "$textofbutton",
          style: TextStyle(color: color_of_text),
        ),
      ),
    );
  }

  Widget sign_inbutton(
      String textofbutton, Color color_of_button, Color color_of_text) {
    return AnimatedContainer(
      duration: Duration(microseconds: 200),
      height: ontabsignin ? 47 : 60,
      width: ontabsignin
          ? MediaQuery.of(context).size.width / 1.8
          : MediaQuery.of(context).size.width / 1.5,
      decoration: BoxDecoration(
          color: color_of_button,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.black)),
      child: Center(
        child: Text(
          "$textofbutton",
          style: TextStyle(color: color_of_text),
        ),
      ),
    );
  }

  Widget got_rider(
      String textofbutton, Color color_of_button, Color color_of_text) {
    return AnimatedContainer(
      duration: Duration(microseconds: 200),
      height: ontabsignin ? 47 : 60,
      width: ontabsignin
          ? MediaQuery.of(context).size.width / 1.8
          : MediaQuery.of(context).size.width / 1.5,
      decoration: BoxDecoration(
          color: color_of_button,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.black)),
      child: Center(
        child: Text(
          "$textofbutton",
          style: TextStyle(color: color_of_text),
        ),
      ),
    );
  }

  Widget sign_up_button(
      String textofbutton, Color color_of_button, Color color_of_text) {
    return AnimatedContainer(
      duration: Duration(microseconds: 0),
      height: ontabsignup ? 47 : 60,
      width: ontabsignup
          ? MediaQuery.of(context).size.width / 1.8
          : MediaQuery.of(context).size.width / 1.5,
      decoration: BoxDecoration(
          color: color_of_button,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.black)),
      child: Center(
        child: Text(
          "$textofbutton",
          style: TextStyle(color: color_of_text),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 200,
              child: Image.asset("assets/Drawing1.png"),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTapDown: (value) {
                setState(() {
                  ontabsignup = true;
                });
              },
              onTap: () {
                setState(() {
                  ontabsignup = false;
                });
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
              child: sign_up_button("Sign up", Colors.white, Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTapDown: (value) {
                setState(() {
                  ontabsignin = true;
                });
              },
              onTap: () {
                setState(() {
                  ontabsignin = false;
                });
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SigninScreen()));
              },
              child: sign_inbutton("Sign in", Colors.white, Colors.black),
            ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MainMenuScreenrider()));
              },
              child: got_rider("For riders", Colors.white, Colors.black),
            ),
            SizedBox(
              height: 90,
            ),
            GestureDetector(
                // onTapCancel: () {
                //   setState(() {
                //     ontabsignup = false;
                //   });
                // },
                onTapDown: (value) {
                  setState(() {
                    ontabskip = true;
                  });
                },
                onTap: () {
                  setState(() {
                    ontabskip = false;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainDisplayScreen()));
                },
                child: skipbutton("Skip", Colors.black, Colors.white)),
          ],
        ),
      ),
    );
  }
}

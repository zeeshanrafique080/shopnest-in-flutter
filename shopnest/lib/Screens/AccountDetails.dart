import 'package:shopnest/MainMenuScreen.dart';
import 'package:shopnest/Screens/AboutUs.dart';
import 'package:shopnest/Screens/Agreements.dart';
import 'package:shopnest/Screens/HelpCenter.dart';
import 'package:shopnest/Screens/MyOrderList.dart';
import 'package:shopnest/Screens/SignupScreen.dart';
import 'package:shopnest/Screens/custom_Tshirt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountDetails extends StatefulWidget {
  const AccountDetails({Key? key}) : super(key: key);

  @override
  _AccountDetailsState createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  final mauth = FirebaseAuth.instance;
  Widget button(
      String textofbutton, Color color_of_button, Color color_of_text) {
    return Container(
      height: 30,
      width: MediaQuery.of(context).size.width - 90,
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
    return Container(
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            SizedBox(
              height: 15,
            ),
            mauth.currentUser == null
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Welcome",
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "View all your orders and exclusive",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen()));
                          },
                          child:
                              button("Sign In/Up", Colors.black, Colors.white)),
                    ],
                  )
                : Container(),
            SizedBox(
              height: 12,
            ),
            mauth.currentUser == null
                ? Column(
                    children: [
                      Row(
                        children: [
                          FirebaseAuth.instance.currentUser != null
                              ? Container(
                                  padding: EdgeInsets.all(3),
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      shape: BoxShape.circle),
                                  child: Image.asset("assets/download.png",
                                      fit: BoxFit.fill),
                                )
                              : Container(),
                          SizedBox(
                            width: 40,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Country, Language and Currency",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(9),
                                        border: Border.all(color: Colors.grey)),
                                    child: Row(
                                      children: [
                                        Icon(Icons.flag_outlined),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("Pakistan")
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(9),
                                        border: Border.all(color: Colors.grey)),
                                    child: Row(
                                      children: [
                                        Text("PKR"),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(9),
                                        border: Border.all(color: Colors.grey)),
                                    child: Row(
                                      children: [Text("Gujrat")],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                    ],
                  )
                : Container(),
            SizedBox(
              height: 8,
            ),
            Divider(
              color: Colors.black,
            ),
            SizedBox(
              height: 8,
            ),
            mauth.currentUser != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyOrderList()));
                        },
                        child: Text(
                          "Your Orders",
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                    ],
                  )
                : Container(),
            mauth.currentUser != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CustomizeTshirt()));
                        },
                        child: Text(
                          "Customize T shirt",
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                    ],
                  )
                : Container(),
            SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HelpCenter()));
              },
              child: Text(
                "Help Center",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Divider(
              color: Colors.black,
            ),
            SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutUs()));
              },
              child: Text(
                "About Us",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Divider(
              color: Colors.black,
            ),
            SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Agreements()));
              },
              child: Text(
                "Agreements",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainMenuScreen()));
              },
              child: Text(
                "Sign Out",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
          ],
        ));
  }
}

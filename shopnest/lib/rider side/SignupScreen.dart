import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopnest/rider%20side/PendingOrders.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final namecontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final coderecrived = TextEditingController();
  bool disbalebutton = false;
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool make_loading_action = false;

  signup() async {
    try {
      setState(() {
        make_loading_action = true;
      });
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailcontroller.text.toString(),
              password: _passwordcontroller.text.toString())
          .then((value) async {
        if (value.additionalUserInfo!.isNewUser) {
          final custmomerjson = {
            "rider status": "available",
            "rider name": namecontroller.text.toString().trim(),
            "rider phone": phonecontroller.text.toString().trim(),
            "rider country": "none",
            "rider email": _emailcontroller.text.toString().trim(),
            "rider uid": value.user!.uid.toString().trim()
          };
          await FirebaseFirestore.instance
              .collection("riders")
              .doc(value.user!.uid)
              .set(custmomerjson)
              .then((value) {
            setState(() {
              make_loading_action = false;
            });
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PendingOrders()));
          });
        } else {
          print("this email addressed is already used.");
        }
      });
    } catch (exception) {
      final snackBar = SnackBar(content: Text('user already exist'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    setState(() {
      make_loading_action = false;
    });
  }

  Widget TextField(TextEditingController controller, String hint) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'field must contain data';
        }
        return null;
      },
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
        labelText: hint,
      ),
    );
  }

  Widget pass_Field() {
    return TextFormField(
      validator: (value) {
        if (value!.length < 8) {
          return 'atleast 8 words required ';
        }
        if (value.isEmpty) {
          return 'field must contain data';
        }
        return null;
      },
      controller: _passwordcontroller,
      obscureText: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
        labelText: 'Enter Password',
      ),
    );
  }

  // Widget countrypicker() {
  //   return Padding(
  //       padding: EdgeInsets.all(10),
  //       child: SizedBox(
  //         width: double.infinity,
  //         child: CountryListPick(
  //             appBar: AppBar(
  //               backgroundColor: Colors.blue,
  //               title: Text('Select Country'),
  //             ),

  //             // if you need custome picker use this

  //             // To disable option set to false
  //             theme: CountryTheme(
  //               isShowFlag: true,
  //               isShowTitle: true,
  //               isShowCode: true,
  //               isDownIcon: true,
  //               showEnglishName: true,
  //             ),
  //             // Set default value
  //             initialSelection: '+62',
  //             // or
  //             // initialSelection: 'US'
  //             onChanged: (CountryCode? code) {
  //               print(code!.name);
  //               print(code.code);
  //               print(code.dialCode);
  //               print(code.flagUri);
  //             },
  //             // Whether to allow the widget to set a custom UI overlay
  //             useUiOverlay: true,
  //             // Whether the country list should be wrapped in a SafeArea
  //             useSafeArea: false),
  //       ));
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => MainMenuScreen()));
        return Future.value(true);
      },
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(25),
            child: ListView(
              children: [
                Container(
                  height: 150,
                  child: Image.asset("assets/download.jpeg"),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(namecontroller, "enter name"),
                SizedBox(
                  height: 15,
                ),
                TextField(phonecontroller, "enter phone number"),
                SizedBox(
                  height: 15,
                ),
                TextField(_emailcontroller, "enter your email"),
                SizedBox(
                  height: 15,
                ),
                pass_Field(),
                SizedBox(
                  height: 55,
                ),
                GestureDetector(
                    onTap: (() {
                      if (_formKey.currentState!.validate()) {
                        signup();
                      }
                    }),
                    child: button("Sign up", Colors.black, Colors.white))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget button(
      String textofbutton, Color color_of_button, Color color_of_text) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width / 1.5,
      decoration: BoxDecoration(
          color: color_of_button,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.black)),
      child: Center(
        child: make_loading_action
            ? Container(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Text(
                "$textofbutton",
                style: TextStyle(color: color_of_text),
              ),
      ),
    );
  }
}

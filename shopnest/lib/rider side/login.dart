import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'PendingOrders.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final coderecrived = TextEditingController();
  bool disbalebutton = false;

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
        labelText: 'Enter password',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(25),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: ListView(
              children: [
                Container(
                  height: 200,
                  child: Center(
                      child: Text(
                    "Welcome Riders",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  )),
                ),
                SizedBox(
                  height: 60,
                ),
                TextField(_emailcontroller, "enter your email"),
                SizedBox(
                  height: 20,
                ),
                pass_Field(),
                SizedBox(
                  height: 90,
                ),
                GestureDetector(
                    onTap: (() {
                      try {
                        if (_formKey.currentState!.validate()) {
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email:
                                      _emailcontroller.text.toString().trim(),
                                  password: _passwordcontroller.text
                                      .toString()
                                      .trim())
                              .then((value) {
                            if (value.user!.uid.isNotEmpty) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PendingOrders()));
                            }
                          });
                        }
                      } catch (exception) {
                        final snackBar =
                            SnackBar(content: Text('invalid details'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }),
                    child: button("Sign in", Colors.black, Colors.white))
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
        child: disbalebutton
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

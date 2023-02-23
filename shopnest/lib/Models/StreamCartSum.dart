import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StreamCartSum extends StatefulWidget {
  const StreamCartSum({Key? key}) : super(key: key);

  @override
  _StreamCartSumState createState() => _StreamCartSumState();
}

class _StreamCartSumState extends State<StreamCartSum> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection("Consumers")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text("loading");
        }
        return Text(snapshot.data!.get("temp sum").toString());
      },
    );
  }
}

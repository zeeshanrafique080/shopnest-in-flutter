import 'package:adminwallpaper/Screens/managecustomer/ModifyCustomer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:images_picker/images_picker.dart';

class AllRiders extends StatefulWidget {
  const AllRiders({Key? key}) : super(key: key);

  @override
  _AllRidersState createState() => _AllRidersState();
}

class _AllRidersState extends State<AllRiders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("riders").snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                if (snapshot.data!.docs.length == 0) {
                  return Center(
                    child: Text("no customer found"),
                  );
                }
                DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Rider name : "),
                          Spacer(),
                          Text(documentSnapshot.get("rider name"))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text("Phone : "),
                          Spacer(),
                          Text(documentSnapshot.get("rider phone"))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text("Rider status : "),
                          Spacer(),
                          Text(documentSnapshot.get("rider status"))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // ElevatedButton(
                          //     onPressed: () {
                          //       Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //               builder: (context) => ModifyCustomer(
                          //                   customerdocid:
                          //                       documentSnapshot.id)));
                          //     },
                          //     child: Text("modify")),
                          ElevatedButton(
                              onPressed: () {
                                documentSnapshot.reference.delete();
                              },
                              child: Text("Delete"))
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

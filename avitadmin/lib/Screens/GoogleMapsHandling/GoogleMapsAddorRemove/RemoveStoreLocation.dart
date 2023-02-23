import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:images_picker/images_picker.dart';

class RemoveStore extends StatefulWidget {
  const RemoveStore({Key? key}) : super(key: key);
  @override
  _RemoveStoreState createState() => _RemoveStoreState();
}

class _RemoveStoreState extends State<RemoveStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(12),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Store Locations")
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      Text(
                        "Store name",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(documentSnapshot.get("Store name")),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Store phone numeber",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(documentSnapshot.get("Store number")),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Store location",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(documentSnapshot.get("Store location")),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            documentSnapshot.reference.delete();
                          },
                          child: Text("Remove Store"))
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

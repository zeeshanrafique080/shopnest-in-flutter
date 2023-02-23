import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:images_picker/images_picker.dart';

class DeleteCatagories extends StatefulWidget {
  const DeleteCatagories({Key? key}) : super(key: key);

  @override
  _DeleteCatagoriesState createState() => _DeleteCatagoriesState();
}

class _DeleteCatagoriesState extends State<DeleteCatagories> {
  String selectedcatagory = "Select";
  late String subcatadocid;

  Widget streamSubCatagories() {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("AvitCatagories")
            .doc(subcatadocid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ExpansionTile(
              childrenPadding: EdgeInsets.symmetric(horizontal: 30),
              trailing: Icon(Icons.arrow_drop_down),
              children: [
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.get("Subcatagories").length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(
                            child: Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  snapshot.data!.get("Subcatagories")[index],
                                  style: TextStyle(fontSize: 22),
                                ))),
                        GestureDetector(
                          onTap: () async {
                            await FirebaseFirestore.instance
                                .collection("AvitCatagories")
                                .doc(subcatadocid)
                                .update({
                              "Subcatagories": FieldValue.arrayRemove(
                                  [snapshot.data!.get("Subcatagories")[index]])
                            });
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        )
                      ],
                    );
                  },
                ),
              ],
              title: Text(
                "subcatagories",
                style: TextStyle(fontSize: 15),
              ));
        });
    ;
  }

  Widget streamCatagories() {
    return StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection("AvitCatagories").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ExpansionTile(
              childrenPadding: EdgeInsets.symmetric(horizontal: 30),
              trailing: Icon(Icons.arrow_drop_down),
              children: [
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot curDoc = snapshot.data!.docs[index];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(
                            child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedcatagory = curDoc.get("CatagoryName");
                              subcatadocid = curDoc.id;
                            });
                          },
                          child: Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                curDoc.get("CatagoryName"),
                                style: TextStyle(fontSize: 22),
                              )),
                        )),
                        GestureDetector(
                            onTap: () async {
                              setState(() {
                                selectedcatagory = "Select";
                              });
                              await FirebaseFirestore.instance
                                  .collection("AvitCatagories")
                                  .doc(curDoc.id)
                                  .delete();
                            },
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ))
                      ],
                    );
                  },
                ),
              ],
              title: Text(
                selectedcatagory,
                style: TextStyle(fontSize: 15),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(12),
        child: ListView(
          children: [
            Container(
              height: 80,
              width: 80,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey)),
              child: Image.asset("assets/testingAvit.jpg"),
            ),
            Divider(
              color: Colors.grey,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "selected catagory will be deleted permanently",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "can delete catagories or either delete subcatagories by select the type of catatgory u want ",
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
            SizedBox(
              height: 30,
            ),
            streamCatagories(),
            selectedcatagory != "Select"
                ? streamSubCatagories()
                : Text("select catagory first")
          ],
        ),
      ),
    );
  }
}

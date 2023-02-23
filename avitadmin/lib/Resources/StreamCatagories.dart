import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class StreamCatagories extends StatefulWidget {
  const StreamCatagories({Key? key}) : super(key: key);

  @override
  _StreamCatagoriesState createState() => _StreamCatagoriesState();
}

class _StreamCatagoriesState extends State<StreamCatagories> {
  String unSelectedcatagory = "Select catagory";
  bool is_cata_selected = false;
  List<String> catagorynames = [];
  int cataindex = 0;
  static late String selectedcatagory;
  List<Widget> createcatagories = [];

  Future<String> funtion() {
    if (selectedcatagory == null) {
      return Future.value("nothing is selected");
    }
    return Future.value(selectedcatagory);
  }

  @override
  Widget build(BuildContext context) {
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
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot curDoc = snapshot.data!.docs[index];
                    catagorynames.add(curDoc.get("CatagoryName").toString());
                    return GestureDetector(
                        onTap: () {
                          print("catagory tapped");
                          setState(() {
                            is_cata_selected = true;
                            cataindex = index;
                          });
                          selectedcatagory =
                              curDoc.get("CatagoryName").toString();
                        },
                        child: Center(
                            child: Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  curDoc.get("CatagoryName"),
                                  style: TextStyle(fontSize: 22),
                                ))));
                  },
                ),
                // Builder(

                //   builder: (context) {
                //     return createcatagories[];
                //   },
                // ),
                // FutureBuilder(
                //   builder:(context, snapshot,) {
                //      return createcatagories[];
                //   }, )
              ],
              title: Text(
                !is_cata_selected
                    ? unSelectedcatagory
                    : catagorynames[cataindex],
                style: TextStyle(fontSize: 20),
              ));
        });
  }
}

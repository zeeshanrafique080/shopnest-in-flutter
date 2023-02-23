import 'package:adminwallpaper/Screens/upload_modify_delete_products/ProductScreenViews/Select_photos.dart';
import 'package:adminwallpaper/Screens/upload_modify_delete_catagories/CatagoryMenu/CreateCatagories.dart';
import 'package:adminwallpaper/Screens/upload_modify_delete_catagories/CatagoryMenu/UpgradeExistingCatagory.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  _AddrpState createState() => _AddrpState();
}

class _AddrpState extends State<AddProductScreen> {
  String unSelectedcatagory = "Select catagory";
  String unSelectedsubcatagory = "Sub catagory";
  bool is_cata_selected = false;
  bool is_subcata_selected = false;
  List<String> catagorynames = [];
  List<dynamic> allSubCataNames = [];
  int cataindex = 0;
  String subcatavalue = "";
  List<Widget> createcatagories = [];
  String selected_catagory = "";
  int initial_length = 0;
  bool loading = false;

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
                    catagorynames.add(curDoc.get("CatagoryName").toString());
                    return GestureDetector(
                        onTap: () async {
                          print("catagory tapped");
                          await FirebaseFirestore.instance
                              .collection("AvitCatagories")
                              .doc(curDoc.id)
                              .get()
                              .then((value) {
                            setState(() {
                              allSubCataNames = value.get("Subcatagories");
                            });
                          });
                          setState(() {
                            is_cata_selected = true;
                            cataindex = index;
                            selected_catagory =
                                curDoc.get("CatagoryName").toString();
                          });
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
              ],
              title: Text(
                !is_cata_selected
                    ? unSelectedcatagory
                    : catagorynames[cataindex],
                style: TextStyle(fontSize: 15),
              ));
        });
    ;
  }

  Widget streamSubCatagories() {
    return selected_catagory.isNotEmpty
        ? ExpansionTile(
            childrenPadding: EdgeInsets.symmetric(horizontal: 30),
            trailing: Icon(Icons.arrow_drop_down),
            children: [
              is_cata_selected
                  ? ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: allSubCataNames.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              print("catagory tapped");
                              setState(() {
                                is_subcata_selected = true;
                                subcatavalue = allSubCataNames[index];
                              });
                            },
                            child: Center(
                                child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      allSubCataNames[index],
                                      style: TextStyle(fontSize: 22),
                                    ))));
                      },
                    )
                  : Center(
                      child: Text("Select catagory first"),
                    ),
            ],
            title: Text(
              !is_subcata_selected ? unSelectedsubcatagory : subcatavalue,
              style: TextStyle(fontSize: 15),
            ))
        : Center(
            child: Text("Select catagory first"),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 15),
        child: ListView(
          shrinkWrap: true,
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
              "Catagory selection",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Selected catagory & sub catagory \n will have updated according to the data \n entered by the admin in future ",
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateCatagories()));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(12)),
                    child: Text(
                      "add Catagory",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpgradeExistingCatagory()));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(12)),
                    child: Text(
                      "add Sub-Catagory",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            streamCatagories(),
            SizedBox(
              height: 20,
            ),
            streamSubCatagories(),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                if (is_cata_selected && is_subcata_selected) {
                  setState(() {
                    loading = true;
                  });
                  await FirebaseFirestore.instance
                      .collection("Store Products")
                      .add({
                    "Ready to Display": "false",
                    "item catagory": catagorynames[cataindex].toString(),
                    "item sub_catagory": subcatavalue.toString(),
                  }).then((value) {
                    setState(() {
                      loading = false;
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectPhoto(
                                  docid: value.id.toString(),
                                )));
                  });
                } else {
                  print("complete the details");
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: loading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          "Next",
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

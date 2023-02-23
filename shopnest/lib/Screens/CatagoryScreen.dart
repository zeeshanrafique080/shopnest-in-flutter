import 'package:shopnest/Screens/ViewAllProducts.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class FirstCatagoryScreen extends StatefulWidget {
  const FirstCatagoryScreen({Key? key}) : super(key: key);

  @override
  _FirstCatagoryScreenState createState() => _FirstCatagoryScreenState();
}

class _FirstCatagoryScreenState extends State<FirstCatagoryScreen> {
  List<Icon> trailingicon = [];
  List subcatagory = [];
  List catagoryname = [];
  int grandindex = 0;
  List<List> GrandTotalsubcatagory = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(25),
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("AvitCatagories")
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, superindex) {
                grandindex = superindex;
                DocumentSnapshot curDoc = snapshot.data!.docs[superindex];
                catagoryname.add(curDoc.get("CatagoryName"));
                subcatagory = curDoc.get("Subcatagories");
                GrandTotalsubcatagory.add(subcatagory);
                trailingicon.add(Icon(Icons.add));
                return AnimationConfiguration.staggeredList(
                  position: superindex,
                  duration: const Duration(milliseconds: 575),
                  child: SlideAnimation(
                    curve: Curves.fastLinearToSlowEaseIn,
                    verticalOffset: 50.0,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: ExpansionTile(
                          onExpansionChanged: (status) {
                            print(status);
                            print(curDoc.get("Subcatagories").length);
                            setState(() {
                              trailingicon[superindex] =
                                  status ? Icon(Icons.remove) : Icon(Icons.add);
                            });
                          },
                          childrenPadding: EdgeInsets.symmetric(horizontal: 30),
                          trailing: trailingicon[superindex],
                          children: [
                            subcatagory.length.isFinite
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        curDoc.get("Subcatagories").length,
                                    itemBuilder: (context, index) {
                                      if (subcatagory.isEmpty) {
                                        return CircularProgressIndicator();
                                      }
                                      // if (subcatagory.isEmpty) {
                                      //   return CircularProgressIndicator();
                                      // }

                                      return GestureDetector(
                                        onTap: () {
                                          print(curDoc.get("CatagoryName"));
                                          print(
                                              GrandTotalsubcatagory[superindex]
                                                  [index]);

                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return ViewAllProducts(
                                                cataname:
                                                    curDoc.get("CatagoryName"),
                                                subcataname:
                                                    GrandTotalsubcatagory[
                                                        superindex][index]);
                                          }));
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                GrandTotalsubcatagory[
                                                    superindex][index],
                                                style: TextStyle(fontSize: 15),
                                              ),
                                              Icon(
                                                Icons.arrow_forward,
                                                size: 18,
                                                color: Colors.black,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : CircularProgressIndicator()
                          ],
                          title: Text(
                            catagoryname[superindex],
                            style: TextStyle(fontSize: 20),
                          )),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}

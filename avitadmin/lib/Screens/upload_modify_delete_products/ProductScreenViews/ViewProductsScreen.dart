import 'package:adminwallpaper/Screens/upload_modify_delete_products/ProductScreenViews/ModifyattributesScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ViewProductsScreen extends StatefulWidget {
  const ViewProductsScreen({Key? key}) : super(key: key);

  @override
  _ViewProductsScreenState createState() => _ViewProductsScreenState();
}

class _ViewProductsScreenState extends State<ViewProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(12),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Store Products")
              .where("Ready to Display", isEqualTo: "true")
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            return GridView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.65,
                    //  (MediaQuery.of(context).size.width /1.2) /
                    //     (MediaQuery.of(context).size.height / 2.7),
                    mainAxisSpacing: 13,
                    crossAxisSpacing: 18,
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  DocumentSnapshot curDoc = snapshot.data!.docs[index];
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 575),
                    child: SlideAnimation(
                        curve: Curves.fastLinearToSlowEaseIn,
                        verticalOffset: 50.0,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 400),
                          // decoration: BoxDecoration(
                          //     border: Border.all(color: Colors.black),
                          //     borderRadius: BorderRadius.circular(25)),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(1.0, -3.0),
                                    blurRadius: 1.7,
                                    spreadRadius: .8,
                                    color: Colors.grey),
                              ]),
                          child: Column(
                            children: [
                              Container(
                                height: 160,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Hero(
                                    tag: curDoc.get('colordemos')[0],
                                    child: CachedNetworkImage(
                                        filterQuality: FilterQuality.low,
                                        fit: BoxFit.fill,
                                        height: double.maxFinite,
                                        width: double.maxFinite,
                                        placeholder: (context, url) {
                                          return Container(
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/testingAvit.jpg'))),
                                          );
                                        },
                                        //net prob
                                        imageUrl: curDoc.get('colordemos')[0]),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(curDoc.get("product name"),
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold)),
                                        Spacer(),
                                        GestureDetector(
                                          onTap: () async {
                                            await FirebaseFirestore.instance
                                                .collection("Store Products")
                                                .doc(curDoc.id)
                                                .delete();
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Lorem ipsum",
                                            style: TextStyle(
                                              fontSize: 12,
                                            )),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(curDoc.get("product price"),
                                            style: TextStyle(
                                              fontSize: 12,
                                            )),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ModifyattributeScreen(
                                                        docid: curDoc.id)));
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 18, vertical: 4),
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Text(
                                          "Modify Now",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
                  );
                });
          },
        ),
      ),
    );
  }
}

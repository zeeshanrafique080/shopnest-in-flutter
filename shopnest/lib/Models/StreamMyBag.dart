import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:progressive_image/progressive_image.dart';

class StreamMyBag extends StatefulWidget {
  const StreamMyBag({Key? key}) : super(key: key);

  @override
  _StreamMyBagState createState() => _StreamMyBagState();
}

class _StreamMyBagState extends State<StreamMyBag> {
  List<int> amountofproduct = [];

  inventorychexk(int orderedamount, productdoc, int index) async {
    await FirebaseFirestore.instance
        .collection("Store Products")
        .doc(productdoc)
        .get()
        .then((value) {
      if (int.tryParse(value.get("product_inventory"))! >= orderedamount) {
        print("stock is available ");
      } else {
        print("stock unavailable");
        setState(() {
          amountofproduct[index]--;
        });
      }
      ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("Consumers")
          .doc(FirebaseAuth.instance.currentUser!.uid.toString())
          .collection("My Bag")
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.docs.length == 0) {
          return Container(
            padding: EdgeInsets.only(left: 6, right: 6, bottom: 3, top: 3),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(9)),
            child: Center(
              child: Text("bag is empty"),
            ),
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot curDoc = snapshot.data!.docs[index];
            amountofproduct.add(1);
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 575),
              child: SlideAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                verticalOffset: 50.0,
                child: Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(4),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Hero(
                            tag: curDoc.get('product_image'),
                            child: ProgressiveImage(
                                placeholder: AssetImage('assets/splash.PNG'),
                                thumbnail:
                                    NetworkImage(curDoc.get('product_image')),
                                image:
                                    NetworkImage(curDoc.get('product_image')),
                                width: 60,
                                height: 80)),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Text(curDoc.get('product_name'),
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                          Text(curDoc.get('product_short description'),
                              style: TextStyle(
                                fontSize: 12,
                              )),
                          Text(curDoc.get('product_price'),
                              style: TextStyle(
                                fontSize: 12,
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                padding: EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.black,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        setState(() {
                                          amountofproduct[index]++;
                                        });
                                        await inventorychexk(
                                            amountofproduct[index],
                                            curDoc.get('product_doc_id'),
                                            index);
                                      },
                                      child: Icon(
                                        Icons.arrow_drop_up_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      amountofproduct[index].toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (amountofproduct[index] > 1) {
                                          setState(() {
                                            amountofproduct[index]--;
                                          });
                                        }
                                      },
                                      child: Icon(
                                        Icons.arrow_drop_down_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await FirebaseFirestore.instance
                                      .collection("Consumers")
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid
                                          .toString())
                                      .collection("My Bag")
                                      .doc(curDoc.id.toString())
                                      .delete();
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

import 'dart:math';

import 'package:shopnest/Models/StreamCartSum.dart';
import 'package:shopnest/Models/StreamMyBag.dart';
import 'package:shopnest/PayPalMethod/PaypalPayment.dart';
import 'package:shopnest/Screens/ChoosePaymentScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:progressive_image/progressive_image.dart';

class MyBagScreen extends StatefulWidget {
  const MyBagScreen({Key? key}) : super(key: key);

  @override
  _MyBagScreenState createState() => _MyBagScreenState();
}

class _MyBagScreenState extends State<MyBagScreen> {
  var random = new Random();
  String chlidref = "836488";
  List<int?> sum = [];
  int? price;
  bool loaddata = false;
  int? sumofproducts = 0;
  late int total;
  bool isaddtioncomplete = true;
  bool isSubtractiondone = true;
  @override
  void initState() {
    super.initState();
    chlidref = random.nextInt(1000000).toString();
  }

  List<int> amountofproduct = [];

  streamtotalamount() async {
    await FirebaseFirestore.instance
        .collection("Consumers")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        total = int.parse(value.get("temp sum"));
      });
    });
  }

  subtracttotalbudget(productprice, docid, quantity) async {
    await streamtotalamount();
    int sum = total - int.parse(productprice);
    await FirebaseFirestore.instance
        .collection("Consumers")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"temp sum": sum.toString()});

    await FirebaseFirestore.instance
        .collection("Consumers")
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .collection("My Bag")
        .doc(docid)
        .update({"purchase_quantity": (quantity - 1).toString()});
    isSubtractiondone = true;
  }

  inventorychexk(String docid, int orderedamount, productdoc, int index,
      String productprice) async {
    await FirebaseFirestore.instance
        .collection("Store Products")
        .doc(productdoc)
        .get()
        .then((value) async {
      if (int.tryParse(value.get("product_inventory"))! >= orderedamount) {
        print("stock is available ");
        await updategrandsum(productprice);
        await upgradequantity(docid, orderedamount);
        isaddtioncomplete = true;
      } else {
        print("stock unavailable");
        setState(() {
          amountofproduct[index]--;
        });
        isaddtioncomplete = true;
      }
      ;
    });
  }

  updategrandsum(String productprice) async {
    await streamtotalamount();
    int sum = int.parse(productprice) + total;
    await FirebaseFirestore.instance
        .collection("Consumers")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"temp sum": sum.toString()});
  }

  upgradequantity(docid, quantity) async {
    await FirebaseFirestore.instance
        .collection("Consumers")
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .collection("My Bag")
        .doc(docid)
        .update({"purchase_quantity": (quantity + 1).toString()});
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
        child: loaddata
            ? CircularProgressIndicator(
                color: Colors.white,
              )
            : Text(
                "$textofbutton",
                style: TextStyle(color: color_of_text),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          padding: EdgeInsets.all(25),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: FirebaseAuth.instance.currentUser != null
              ? StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Consumers")
                      .doc(FirebaseAuth.instance.currentUser!.uid.toString())
                      .collection("My Bag")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data!.docs.length == 0) {
                      return Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9)),
                        child: Center(child: Text("bag is empty")),
                      );
                    }
                    return ListView(
                      shrinkWrap: true,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.grey[700],
                                )),
                            SizedBox(
                              width: 90,
                            ),
                            Text(
                              "My Bag",
                              style: TextStyle(
                                  fontSize: 26, color: Colors.grey[700]),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot curDoc =
                                    snapshot.data!.docs[index];

                                amountofproduct.add(
                                    int.parse(curDoc.get('purchase_quantity')));

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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: ProgressiveImage(
                                                placeholder: AssetImage(
                                                    'assets/splash.PNG'),
                                                thumbnail: NetworkImage(curDoc
                                                    .get('product_image')),
                                                image: NetworkImage(curDoc
                                                    .get('product_image')),
                                                width: 60,
                                                height: 80),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            children: [
                                              Text(curDoc.get('product_name'),
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(
                                                  curDoc.get(
                                                      'product_short description'),
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
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      color: Colors.black,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () async {
                                                            if (isaddtioncomplete) {
                                                              isaddtioncomplete =
                                                                  false;

                                                              await inventorychexk(
                                                                  curDoc.id,
                                                                  amountofproduct[
                                                                      index],
                                                                  curDoc.get(
                                                                      'product_doc_id'),
                                                                  index,
                                                                  curDoc.get(
                                                                      'product_price'));
                                                              setState(() {
                                                                amountofproduct[
                                                                    index]++;
                                                              });
                                                            }
                                                          },
                                                          child: Icon(
                                                            Icons
                                                                .arrow_drop_up_rounded,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 4,
                                                        ),
                                                        Text(
                                                          amountofproduct[index]
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        SizedBox(
                                                          width: 4,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () async {
                                                            if (amountofproduct[
                                                                        index] >
                                                                    1 &&
                                                                isSubtractiondone) {
                                                              isSubtractiondone =
                                                                  false;
                                                              await subtracttotalbudget(
                                                                  curDoc.get(
                                                                      'product_price'),
                                                                  curDoc.id,
                                                                  amountofproduct[
                                                                      index]);
                                                              setState(() {
                                                                amountofproduct[
                                                                    index]--;
                                                              });
                                                            }
                                                          },
                                                          child: Icon(
                                                            Icons
                                                                .arrow_drop_down_rounded,
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
                                                      await streamtotalamount();
                                                      if (total != null) {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                "Consumers")
                                                            .doc(FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid
                                                                .toString())
                                                            .update({
                                                          "temp sum": (total -
                                                                  amountofproduct[
                                                                          index] *
                                                                      int.parse(
                                                                          curDoc
                                                                              .get('product_price')))
                                                              .toString()
                                                        });
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                "Consumers")
                                                            .doc(FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid
                                                                .toString())
                                                            .collection(
                                                                "My Bag")
                                                            .doc(curDoc.id
                                                                .toString())
                                                            .delete();
                                                      }
                                                      setState(() {
                                                        amountofproduct
                                                            .removeAt(index);
                                                      });
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
                            ),
                            Divider(
                              color: Colors.black,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 12),
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.grey)),
                              child: Row(
                                children: [
                                  Text("Promo Code :"),
                                  Spacer(),
                                  Text("$chlidref"),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 12),
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.grey)),
                              child: Row(
                                children: [
                                  Text("Total Amount :"),
                                  Spacer(),
                                  StreamCartSum()
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 9,
                            ),
                            GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    loaddata = true;
                                  });
                                  await streamtotalamount();
                                  List<String> productquntity = [];
                                  List<String> productname = [];
                                  List<String> productimages = [];
                                  List<String> productprice = [];
                                  String length = "";
                                  if (total != null) {
                                    await FirebaseFirestore.instance
                                        .collection("Consumers")
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid
                                            .toString())
                                        .collection("My Bag")
                                        .get()
                                        .then((value) {
                                      length = value.docs.length.toString();
                                      value.docs.forEach((element) {
                                        productprice
                                            .add(element.get("product_price"));
                                        productname
                                            .add(element.get("product_name"));
                                        productimages
                                            .add(element.get("product_image"));
                                        productquntity.add(
                                            element.get("purchase_quantity"));
                                      });
                                    }).then((value) async {
                                      await FirebaseFirestore.instance
                                          .collection("Sales")
                                          .add({
                                        "total number of items": length,
                                        "product_price": productprice,
                                        "products_name": productname,
                                        "product_quantity": productquntity,
                                        "product_images": productimages,
                                        "visible_order": "false",
                                      }).then((value) {
                                        setState(() {
                                          loaddata = false;
                                        });
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        ChoosePaymentScreen(
                                                          docid: value.id,
                                                          totalamount:
                                                              total.toString(),
                                                          promo: chlidref
                                                              .toString(),
                                                        )));
                                      });
                                    });
                                  }
                                },
                                child: button(
                                    "Buy it Now", Colors.black, Colors.white)),
                          ],
                        )
                      ],
                    );
                  },
                )
              : Center(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(9)),
                    child: Text(" Signin & view your cart"),
                  ),
                )),
    );
  }
}

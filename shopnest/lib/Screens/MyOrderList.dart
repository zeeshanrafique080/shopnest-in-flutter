import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyOrderList extends StatefulWidget {
  const MyOrderList({Key? key}) : super(key: key);

  @override
  _MyOrderListState createState() => _MyOrderListState();
}

class _MyOrderListState extends State<MyOrderList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20),
        color: Colors.black.withOpacity(.7),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Sales")
              .where("customer_uid",
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text("No Order placed yet",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Text("No Order placed yet",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  );
                }
                DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.grey[800]!,
                      Colors.grey[600]!,
                      Colors.grey[400]!,
                      Colors.grey[200]!,
                    ]),
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/testingAvit.jpg"),
                                fit: BoxFit.fill),
                            shape: BoxShape.circle),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      Row(
                        children: [
                          Text(
                            "Net total : ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Spacer(),
                          Text(
                              "${documentSnapshot.get("Net_total_amount")} dollars")
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            "Promo Code : ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Spacer(),
                          Text(
                            documentSnapshot.get("promo_code"),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            "transaction type : ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Spacer(),
                          Text(
                            documentSnapshot.get("transaction_type"),
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      ExpansionTile(
                        title: Text(
                          "Details",
                          style: TextStyle(color: Colors.white),
                        ),
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: int.parse(
                                documentSnapshot.get("total number of items")),
                            itemBuilder: (context, index) {
                              return Container(
                                  margin: EdgeInsets.symmetric(vertical: 12),
                                  padding: EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: Colors.black, width: .3)),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Product name : ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          Spacer(),
                                          Text(documentSnapshot
                                              .get("products_name")[index])
                                        ],
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Quantity : ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          Spacer(),
                                          Text(documentSnapshot
                                              .get("product_quantity")[index])
                                        ],
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Price/item  :",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          Spacer(),
                                          Text(documentSnapshot
                                              .get("product_price")[index])
                                        ],
                                      ),
                                    ],
                                  ));
                            },
                          )
                        ],
                      ),
                      if (documentSnapshot.get("Order Status") == "cancel")
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              "this Order is canceled",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      if (documentSnapshot.get("Order Status") == "pending")
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              "your order is pending",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      if (documentSnapshot.get("Order Status") ==
                          "assigned to driver")
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              "Order is on the way",
                              style: TextStyle(color: Colors.amber),
                            ),
                          ),
                        ),
                      if (documentSnapshot.get("Order Status") == "sold")
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              "Successfully received",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
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

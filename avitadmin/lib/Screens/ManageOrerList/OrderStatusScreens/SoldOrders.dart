import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SoldOrder extends StatefulWidget {
  const SoldOrder({Key? key}) : super(key: key);

  @override
  _SoldOrderState createState() => _SoldOrderState();
}

class _SoldOrderState extends State<SoldOrder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(12),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Sales")
            .where("visible_order", isEqualTo: "true")
            .where("Order Status", isEqualTo: "sold")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              if (snapshot.data!.docs.length == 0) {
                return Center(
                  child: Text("no pending order yet"),
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
                          "Customer name : ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Spacer(),
                        Text(documentSnapshot.get("customer_first_name"))
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text(
                          "Net total : ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
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
                              fontWeight: FontWeight.bold, color: Colors.white),
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
                              fontWeight: FontWeight.bold, color: Colors.white),
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
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text(
                          "Order Status : ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Spacer(),
                        Text(
                          documentSnapshot.get("Order Status"),
                          style: TextStyle(
                            color: Colors.amber[900],
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    ExpansionTile(
                      title: Text(
                        "Product details",
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
                    ExpansionTile(
                      title: Text(
                        "location details details",
                        style: TextStyle(color: Colors.white),
                      ),
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Customer Country : ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Spacer(),
                                Text(documentSnapshot.get("customer_country"))
                              ],
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              children: [
                                Text(
                                  "customer city : ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Spacer(),
                                Text(documentSnapshot.get("customer_city"))
                              ],
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              children: [
                                Text(
                                  "full address",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Spacer(),
                                Text(documentSnapshot
                                    .get("customer_full_address"))
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          "Successfully delivered",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

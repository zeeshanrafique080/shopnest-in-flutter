import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopnest/MainMenuScreen.dart';

class PendingOrders extends StatefulWidget {
  const PendingOrders({Key? key}) : super(key: key);

  @override
  _PendingOrdersState createState() => _PendingOrdersState();
}

class _PendingOrdersState extends State<PendingOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "My orders",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MainMenuScreen()));
            },
            icon: Icon(Icons.login_rounded),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(12),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Sales")
              .where("visible_order", isEqualTo: "true")
              .where("Order Status", isEqualTo: "assigned to driver")
              .where("assigned driver",
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.black,
              ));
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                if (snapshot.data!.docs.length == 0) {
                  return Center(
                    child: Text(
                      "no pending order yet",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
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
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
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
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            "Order Status : ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.greenAccent[700]),
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection("Sales")
                                    .doc(documentSnapshot.id)
                                    .update({"Order Status": "sold"}).then(
                                        (value) {
                                  FirebaseFirestore.instance
                                      .collection("riders")
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .update({"rider status": "available"});
                                }).then((value) {
                                  FirebaseFirestore.instance
                                      .collection("reports")
                                      .add({
                                    "date":
                                        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                                    "total_amount": ""
                                  });
                                });
                              },
                              child: Text("Claim delivered")),
                          ElevatedButton(
                              style:
                                  ElevatedButton.styleFrom(primary: Colors.red),
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection("Sales")
                                    .doc(documentSnapshot.id)
                                    .update({
                                  "Order Status": "cancel",
                                  "canceled by": "staff"
                                });
                                if (snapshot.data!.docs.length > 0) {
                                  print("orders aare availble");
                                } else {
                                  FirebaseFirestore.instance
                                      .collection("riders")
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .update({"rider status": "available"});
                                }
                              },
                              child: Text("cancel order"))
                        ],
                      )
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

import 'package:shopnest/PayPalMethod/PaypalPayment.dart';
import 'package:shopnest/Screens/MainDisplayScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChoosePaymentScreen extends StatefulWidget {
  final String totalamount;
  final String promo;
  final String docid;

  const ChoosePaymentScreen(
      {Key? key,
      required this.totalamount,
      required this.promo,
      required this.docid})
      : super(key: key);

  @override
  _ChoosePaymentScreenState createState() => _ChoosePaymentScreenState();
}

class _ChoosePaymentScreenState extends State<ChoosePaymentScreen> {
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final fulladdress = TextEditingController();
  final country = TextEditingController();
  final city = TextEditingController();
  final addressname = TextEditingController();
  final phone = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool uploadpayment = false;
  bool paymentmethodselected = false;
  Widget shortfields(
      TextEditingController controller, String hint, double width) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 17),
      width: width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(19),
      ),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "must enter details first";
          }
        },
        controller: controller,
        cursorColor: Colors.black,
        decoration: InputDecoration(border: InputBorder.none, hintText: hint),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  width: 70,
                ),
                Text("Complete Order",
                    style: TextStyle(fontWeight: FontWeight.bold))
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Text(
                  "Address",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                shortfields(firstname, "first name", 120),
                SizedBox(
                  width: 20,
                ),
                shortfields(lastname, "last name", 120),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            shortfields(fulladdress, "enter your full address", 200),
            SizedBox(
              height: 10,
            ),
            shortfields(phone, "contact number", 200),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                shortfields(country, "your country", 140),
                SizedBox(
                  width: 20,
                ),
                shortfields(city, "your city", 120)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            shortfields(addressname, "address name", 200),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  child: Text("save address"),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  paymentmethodselected = true;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black)),
                child: Row(
                  children: [
                    Icon(
                      Icons.delivery_dining_rounded,
                      color: Colors.green,
                    ),
                    Spacer(),
                    Text("cash on delivery"),
                    SizedBox(
                      width: 10,
                    ),
                    AnimatedContainer(
                      duration: Duration.zero,
                      height: 16,
                      width: 16,
                      decoration: BoxDecoration(
                        color: paymentmethodselected
                            ? Colors.black
                            : Colors.transparent,
                        border: Border.all(color: Colors.black),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(
            //   height: 20,
            // ),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.of(context).push(
            //       MaterialPageRoute(
            //         builder: (BuildContext context) => PaypalPayment(
            //           totalamount: widget.totalamount.toString(),
            //           onFinish: (number) async {
            //             // payment done
            //             if (number != null) {
            //               if (_formKey.currentState!.validate()) {
            //                 print("number containes some value ");
            //                 print('order id: ' + number);
            //                 await FirebaseFirestore.instance
            //                     .collection("Sales")
            //                     .doc(widget.docid)
            //                     .update({
            //                   "transaction_type": "Paypal",
            //                   "transaction id": number.toString(),
            //                   "customer_first_name":
            //                       firstname.text.trim().toString(),
            //                   "customer_last_name":
            //                       lastname.text.trim().toString(),
            //                   "customer_full_address":
            //                       fulladdress.text.trim().toString(),
            //                   "customer_country":
            //                       country.text.trim().toString(),
            //                   "customer_city": city.text.trim().toString(),
            //                   "address_name":
            //                       addressname.text.trim().toString(),
            //                   "Net_total_amount": widget.totalamount,
            //                   "promo_code": widget.promo,
            //                   "customer_uid": FirebaseAuth
            //                       .instance.currentUser!.uid
            //                       .toString(),
            //                   "customer_phone_no": phone.text.trim().toString(),
            //                   "visible_order": "true",
            //                   "cancel_order": "false"
            //                 }).then((value) async {
            //                   await FirebaseFirestore.instance
            //                       .collection("Consumers")
            //                       .doc(FirebaseAuth.instance.currentUser!.uid)
            //                       .update({
            //                     "temp sum": "0",
            //                   });

            //                   await FirebaseFirestore.instance
            //                       .collection("Consumers")
            //                       .doc(FirebaseAuth.instance.currentUser!.uid)
            //                       .collection("My Bag")
            //                       .get()
            //                       .then((value) async {
            //                     value.docs.forEach((element) async {
            //                       await element.reference.delete();
            //                     });
            //                   });

            //                   final snackBar = SnackBar(
            //                       content: Text(
            //                           'your order has successfullty placed'));
            //                   ScaffoldMessenger.of(context)
            //                       .showSnackBar(snackBar);
            //                   Navigator.of(context).push(MaterialPageRoute(
            //                       builder: (BuildContext context) =>
            //                           MainDisplayScreen()));
            //                 });
            //                 ;
            //               }
            //             } else {
            //               print('number is null');
            //             }
            //           },
            //         ),
            //       ),
            //     );
            //   },
            //   child: Container(
            //     padding: EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(20),
            //         border: Border.all(color: Colors.black)),
            //     child: Row(
            //       children: [
            //         Icon(
            //           Icons.payment_outlined,
            //           color: Colors.blue,
            //         ),
            //         Spacer(),
            //         Text("PayPal"),
            //         SizedBox(
            //           width: 10,
            //         ),
            //         Container(
            //           height: 16,
            //           width: 16,
            //           decoration: BoxDecoration(
            //             border: Border.all(color: Colors.black),
            //             shape: BoxShape.circle,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      if (paymentmethodselected) {
                        setState(() {
                          uploadpayment = true;
                        });
                        await FirebaseFirestore.instance
                            .collection("Sales")
                            .doc(widget.docid)
                            .update({
                          "assigned driver": "none",
                          "Order Status": "pending",
                          "canceled by": "no one",
                          "customer_first_name":
                              firstname.text.trim().toString(),
                          "customer_last_name": lastname.text.trim().toString(),
                          "customer_full_address":
                              fulladdress.text.trim().toString(),
                          "customer_country": country.text.trim().toString(),
                          "customer_city": city.text.trim().toString(),
                          "address_name": addressname.text.trim().toString(),
                          "Net_total_amount": widget.totalamount,
                          "promo_code": widget.promo,
                          "customer_uid":
                              FirebaseAuth.instance.currentUser!.uid.toString(),
                          "customer_phone_no": phone.text.trim().toString(),
                          "transaction_type": "CashOnDelivery",
                          "transaction id": "none",
                          "visible_order": "true",
                          "cancel_order": "false"
                        }).then((value) async {
                          await FirebaseFirestore.instance
                              .collection("Consumers")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection("My Bag")
                              .get()
                              .then((value) {
                            value.docs.forEach((element) async {
                              await FirebaseFirestore.instance
                                  .collection("Store Products")
                                  .doc(element.get("product_doc_id"))
                                  .get()
                                  .then((value) {
                                value.reference.update({
                                  "sales quantity": (int.parse(
                                              value.get('sales quantity')) +
                                          int.parse(
                                              element.get('purchase_quantity')))
                                      .toString()
                                });

                                print("inventory is updated");
                              });
                            });
                          });
                          await FirebaseFirestore.instance
                              .collection("Consumers")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .update({
                            "temp sum": "0",
                          });

                          await FirebaseFirestore.instance
                              .collection("Consumers")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection("My Bag")
                              .get()
                              .then((value) async {
                            value.docs.forEach((element) async {
                              await element.reference.delete();
                            });
                          });

                          final snackBar = SnackBar(
                              content:
                                  Text('your order has successfullty placed'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  MainDisplayScreen()));
                        });
                      } else {
                        final snackBar = SnackBar(
                            content: Text('select payment type first'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 170,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black),
                    child: Center(
                      child: uploadpayment
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              "Complete now",
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}

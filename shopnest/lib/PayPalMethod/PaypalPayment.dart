// import 'dart:core';
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'PaypalServices.dart';
// import 'package:firebase_database/firebase_database.dart';

// class PaypalPayment extends StatefulWidget {
//   final Function onFinish;
//   final totalamount;

//   PaypalPayment({required this.onFinish, required this.totalamount});

//   @override
//   State<StatefulWidget> createState() {
//     return PaypalPaymentState();
//   }
// }

// class PaypalPaymentState extends State<PaypalPayment> {
//   String domainsb = "https://api.sandbox.paypal.com"; // for sandbox mode
//   String domainprod = "https://api.paypal.com"; // for production mode
//   String domain = '';
//   // change clientId and secret with your own, provided by paypal
//   String clientId = '';
//   //'Aehu3NVbe52c89d7aY9Wx-CsPxdg-fpaH5pT0eujP0WUz3nS57uQbD4YPEoD-rClmzQGAD-F6u1sZVgm';
//   String secret = '';
//   //'EM2AUemgJsP5w54akGG-7HYoron45mgA8g6yDty_PwHLvRaNeBOV2DuH4jkvHSOGcHW4AmJkiqXWuVS5';

//   GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   var checkoutUrl;
//   var executeUrl;
//   var accessToken;
//   PaypalServices services = PaypalServices();

//   // you can change default currency according to your need
//   Map<dynamic, dynamic> defaultCurrency = {
//     "symbol": "USD ",
//     "decimalDigits": 2,
//     "symbolBeforeTheNumber": true,
//     "currency": "USD"
//   };

//   bool isEnableShipping = false;
//   bool isEnableAddress = false;

//   String returnURL = 'return.example.com';
//   String cancelURL = 'cancel.example.com';
//   final _database = FirebaseDatabase.instance.reference();
//   String domaintype = '';

//   @override
//   void initState() {
//     super.initState();
//     print(widget.totalamount);

//     Future.delayed(Duration.zero, () async {
//       try {
//         _database.child('paypal/clientid').once().then((DataSnapshot snapshot) {
//           print(snapshot.value);
//           this.clientId = snapshot.value;
//           _database.child('paypal/key').once().then((DataSnapshot snapshot) {
//             this.secret = snapshot.value;
//             _database
//                 .child('paypal/acctype')
//                 .once()
//                 .then((DataSnapshot snapshot) async {
//               this.domaintype = snapshot.value;
//               if (this.domaintype == "sandbox")
//                 this.domain = this.domainsb;
//               else
//                 this.domain = this.domainprod;
//               accessToken = await services.getAccessToken(
//                   this.clientId, this.secret, this.domain);

//               final transactions = getOrderParams();
//               final res =
//                   await services.createPaypalPayment(transactions, accessToken);
//               if (res != null) {
//                 setState(() {
//                   checkoutUrl = res["approvalUrl"];
//                   executeUrl = res["executeUrl"];
//                 });
//               }
//             });
//           });

//           //this.domaintype = snapshot.value.acctype;
//         });
//       } catch (e) {
//         print('exception: ' + e.toString());
//         final snackBar = SnackBar(
//           content: Text(e.toString()),
//           duration: Duration(seconds: 10),
//           action: SnackBarAction(
//             label: 'Close',
//             onPressed: () {
//               // Some code to undo the change.
//               Navigator.pop(context);
//             },
//           ),
//         );
//         // ignore: deprecated_member_use
//         _scaffoldKey.currentState!.showSnackBar(snackBar);
//       }
//     });
//   }

//   // item name, price and quantity
//   String itemName = 'iPhone X';
//   String itemPrice = '1.99';
//   int quantity = 1;

//   Map<String, dynamic> getOrderParams() {
//     List items = [
//       /* {
//         "name": itemName,
//         "quantity": quantity,
//         "price": itemPrice,
//         "currency": defaultCurrency["currency"]
//       },
//       */
//     ];

//     // checkout invoice details
//     String totalAmount = '1.99';
//     String subTotalAmount = '1.99';
//     String shippingCost = '0';
//     int shippingDiscountCost = 0;
//     String userFirstName = 'Gulshan';
//     String userLastName = 'Yadav';
//     String addressCity = 'Delhi';
//     String addressStreet = 'Mathura Road';
//     String addressZipCode = '110014';
//     String addressCountry = 'India';
//     String addressState = 'Delhi';
//     String addressPhoneNumber = '+919990119091';

//     Map<String, dynamic> temp = {
//       "intent": "sale",
//       "payer": {"payment_method": "paypal"},
//       "transactions": [
//         {
//           "amount": {
//             "total": widget.totalamount,
//             "currency": defaultCurrency["currency"],
//             "details": {
//               "subtotal": widget.totalamount,
//               "shipping": shippingCost,
//               "shipping_discount": ((-1.0) * shippingDiscountCost).toString()
//             }
//           },
//           "description": "The payment transaction description.",
//           "payment_options": {
//             "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
//           },
//           "item_list": {
//             "items": items,
//             if (isEnableShipping && isEnableAddress)
//               "shipping_address": {
//                 "recipient_name": userFirstName + " " + userLastName,
//                 "line1": addressStreet,
//                 "line2": "",
//                 "city": addressCity,
//                 "country_code": addressCountry,
//                 "postal_code": addressZipCode,
//                 "phone": addressPhoneNumber,
//                 "state": addressState
//               },
//           }
//         }
//       ],
//       "note_to_payer": "Contact us for any questions on your order.",
//       "redirect_urls": {"return_url": returnURL, "cancel_url": cancelURL}
//     };
//     return temp;
//   }

//   @override
//   Widget build(BuildContext context) {
//     print(checkoutUrl);

//     if (checkoutUrl != null) {
//       return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Theme.of(context).backgroundColor,
//           leading: GestureDetector(
//             child: Icon(Icons.arrow_back_ios),
//             onTap: () => Navigator.pop(context),
//           ),
//         ),
//         body: WebView(
//           initialUrl: checkoutUrl,
//           javascriptMode: JavascriptMode.unrestricted,
//           navigationDelegate: (NavigationRequest request) {
//             if (request.url.contains(returnURL)) {
//               final uri = Uri.parse(request.url);
//               final payerID = uri.queryParameters['PayerID'];
//               if (payerID != null) {
//                 services
//                     .executePayment(executeUrl, payerID, accessToken)
//                     .then((id) {
//                   widget.onFinish(id);
//                   Navigator.of(context).pop();
//                 });
//               } else {
//                 Navigator.of(context).pop();
//               }
//               Navigator.of(context).pop();
//             }
//             if (request.url.contains(cancelURL)) {
//               Navigator.of(context).pop();
//             }
//             return NavigationDecision.navigate;
//           },
//         ),
//       );
//     } else {
//       return Scaffold(
//         key: _scaffoldKey,
//         appBar: AppBar(
//           leading: IconButton(
//               icon: Icon(Icons.arrow_back),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               }),
//           backgroundColor: Colors.black12,
//           elevation: 0.0,
//         ),
//         body: Center(child: Container(child: CircularProgressIndicator())),
//       );
//     }
//   }
// }

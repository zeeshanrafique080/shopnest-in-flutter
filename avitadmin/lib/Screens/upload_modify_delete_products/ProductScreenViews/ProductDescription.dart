import 'package:adminwallpaper/Screens/MainMenuScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:images_picker/images_picker.dart';

class ProductDescription extends StatefulWidget {
  String docid;
  ProductDescription({Key? key, required this.docid}) : super(key: key);

  @override
  _ProductDescriptionState createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  TextEditingController productname = TextEditingController();
  TextEditingController ussize = TextEditingController();
  TextEditingController uksize = TextEditingController();
  TextEditingController productprice = TextEditingController();
  TextEditingController itemdescription = TextEditingController();
  TextEditingController productcode = TextEditingController();
  TextEditingController productsize = TextEditingController();
  TextEditingController productwidth = TextEditingController();
  TextEditingController productheight = TextEditingController();
  TextEditingController productfabic = TextEditingController();
  TextEditingController totalinventory = TextEditingController();
  List<String> ussizes = [];
  List<String> uksizes = [];
  late bool returntomenu;
  final _formkey = GlobalKey<FormState>();
  Widget textfields(TextEditingController controller, String hint) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "must enter details";
        }
      },
      controller: controller,
      decoration: InputDecoration(labelText: hint),
    );
  }

  Future<void> _showMyDialog(info) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Waring',
            style: TextStyle(
                fontSize: 25,
                fontFamily: 'LobsterTwo Bold',
                color: Colors.black),
          ),
          elevation: 5,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  info,
                  style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'LobsterTwo Bold',
                      color: Colors.black),
                ),
                //Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Got it!',
                  style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'LobsterTwo Bold',
                      color: Colors.black)),
              onPressed: () async {
                setState(() {
                  returntomenu = true;
                });
                await FirebaseFirestore.instance
                    .collection("Store Products")
                    .doc(widget.docid)
                    .delete();
                Navigator.of(context).pop();
                await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainMenuScreen()));
              },
            ),
            TextButton(
              child: Text('no',
                  style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'LobsterTwo Bold',
                      color: Colors.black)),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await _showMyDialog("givien data will be lost");
        return Future.value(returntomenu);
      },
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formkey,
            child: ListView(
              children: [
                Text(
                  "Product info",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "tell us more about the product",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
                SizedBox(
                  height: 15,
                ),
                textfields(productname, "product name"),
                SizedBox(
                  height: 15,
                ),
                textfields(productprice, "product price"),
                SizedBox(
                  height: 15,
                ),
                textfields(productcode, "product code"),
                SizedBox(
                  height: 15,
                ),
                textfields(itemdescription, "item description"),
                SizedBox(
                  height: 15,
                ),
                // textfields(productfabic, "fabic details"),
                // SizedBox(
                //   height: 15,
                // ),
                // textfields(productsize, "Product Size"),
                // SizedBox(
                //   height: 15,
                // ),
                // textfields(productwidth, "Product width"),
                // SizedBox(
                //   height: 15,
                // ),
                // textfields(productheight, "Product height"),
                // SizedBox(
                //   height: 20,
                // ),
                textfields(totalinventory, "inventory in numbers"),
                SizedBox(
                  height: 20,
                ),
                // ExpansionTile(
                //   title: Text("upload Us size"),
                //   children: [
                //     TextField(
                //       controller: ussize,
                //       decoration:
                //           InputDecoration(hintText: "upload one by one"),
                //     ),
                //     ElevatedButton(
                //         onPressed: () {
                //           if (ussize.text.isNotEmpty) {
                //             setState(() {
                //               ussizes.add(ussize.text.trim().toString());
                //             });
                //           }
                //         },
                //         child: Text("upload")),
                //     SizedBox(
                //       height: 10,
                //     ),
                //     Container(
                //       height: 30,
                //       child: ListView.builder(
                //         scrollDirection: Axis.horizontal,
                //         shrinkWrap: true,
                //         itemCount: ussizes.length,
                //         itemBuilder: (context, index) {
                //           return Container(
                //             margin: EdgeInsets.symmetric(horizontal: 4),
                //             decoration: BoxDecoration(
                //                 border: Border.all(color: Colors.black)),
                //             padding: EdgeInsets.symmetric(
                //                 horizontal: 4, vertical: 4),
                //             child: Center(
                //               child: Text(ussizes[index]),
                //             ),
                //           );
                //         },
                //       ),
                //     )
                //   ],
                // ),
                // ExpansionTile(
                //   title: Text("upload Uk size"),
                //   children: [
                //     TextField(
                //       controller: uksize,
                //       decoration:
                //           InputDecoration(hintText: "upload one by one"),
                //     ),
                //     ElevatedButton(
                //         onPressed: () {
                //           if (uksize.text.isNotEmpty) {
                //             setState(() {
                //               uksizes.add(uksize.text.trim().toString());
                //             });
                //           }
                //         },
                //         child: Text("upload")),
                //     SizedBox(
                //       height: 10,
                //     ),
                //     Container(
                //       height: 30,
                //       child: ListView.builder(
                //         scrollDirection: Axis.horizontal,
                //         shrinkWrap: true,
                //         itemCount: uksizes.length,
                //         itemBuilder: (context, index) {
                //           return Container(
                //             margin: EdgeInsets.symmetric(horizontal: 4),
                //             decoration: BoxDecoration(
                //                 border: Border.all(color: Colors.black)),
                //             padding: EdgeInsets.symmetric(
                //                 horizontal: 4, vertical: 4),
                //             child: Center(
                //               child: Text(uksizes[index]),
                //             ),
                //           );
                //         },
                //       ),
                //     )
                //   ],
                // ),
                GestureDetector(
                  onTap: () async {
                    if (_formkey.currentState!.validate()) {
                      await FirebaseFirestore.instance
                          .collection("Store Products")
                          .doc(widget.docid)
                          .update({
                        "sales quantity": 0.toString(),
                        "product_inventory":
                            totalinventory.text.toString().trim(),
                        "Ready to Display": "true",
                        "product name": productname.text.toString().trim(),
                        "product price": productprice.text.toString().trim(),
                        "product code": productcode.text.toString().trim(),
                        "item description":
                            itemdescription.text.toString().trim(),
                        "fabric details": "none",
                        "product size": "none",
                        "product width": "none",
                        "product height": "none",
                        "liked by": [],
                        "Us size": [],
                        "Uk size": [],
                      }).then((value) {
                        final snackBar = SnackBar(
                            content: Text(
                                'product is upload to the store successfully'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainMenuScreen()));
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black),
                    child: Center(
                      child: Text(
                        "submit",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:images_picker/images_picker.dart';

class ModifyattributeScreen extends StatefulWidget {
  final String docid;
  const ModifyattributeScreen({Key? key, required this.docid})
      : super(key: key);

  @override
  _ModifyattributeScreenState createState() => _ModifyattributeScreenState();
}

class _ModifyattributeScreenState extends State<ModifyattributeScreen> {
  TextEditingController productname = TextEditingController();
  TextEditingController productprice = TextEditingController();
  TextEditingController itemdescription = TextEditingController();
  TextEditingController productcode = TextEditingController();
  TextEditingController productsize = TextEditingController();
  TextEditingController productwidth = TextEditingController();
  TextEditingController productheight = TextEditingController();
  TextEditingController productfabic = TextEditingController();
  TextEditingController totalinventory = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  var random = new Random();
  int imagecount = 0;

  List<String> geturls = [];
  List<Media> selectedimages = [];
  List<List> grandtotal = [];
  int? numberofcolor = 0;
  List emptyarray = [];
  List<String> adding_url = [];
  int o = 0;
  List demourls = [];
  late bool returntomenu;

  Widget fields(heading, TextEditingController controller, updatefield) {
    return ExpansionTile(
      title: Text(heading),
      children: [
        Form(
          key: _formKey,
          child: ListView(shrinkWrap: true, children: [
            TextFormField(
              controller: controller,
              validator: (value) {
                if (value!.isEmpty) {
                  return "must enter something";
                }
              },
              decoration: InputDecoration(labelText: "enter data"),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await FirebaseFirestore.instance
                        .collection("Store Products")
                        .doc(widget.docid)
                        .update({
                      "$updatefield": controller.text.trim().toString()
                    });
                  }
                },
                child: Text("submit"))
          ]),
        )
      ],
    );
  }

  Widget pickimages() {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black)),
        onPressed: () async {
          o++;

          await ImagesPicker.pick(count: 4, pickType: PickType.image)
              .then((value) {
            setState(() {
              selectedimages = value!;
            });
          });

          if (selectedimages.length == 4) {
            await upload_to_storage();
          }
        },
        child: Text(
          "pick image",
          style: TextStyle(),
        ));
  }

  upload_to_storage() async {
    await foreach();

    //   if (urlsfetched.isNotEmpty && imagecount == 4) {

    //   } else {
    //     print("");
    //   }
    // }
  }

  foreach() async {
    selectedimages.forEach((element) async {
      String chlidref = random.nextInt(1000000).toString();
      String url = "";
      File image2 = await FlutterNativeImage.compressImage(element.path,
          quality: 80, targetWidth: 600, targetHeight: 600);
      FirebaseStorage.instance
          .ref("AvitRef")
          .child("$chlidref" + "images/profile" + ".jpg")
          .putFile(File(image2.path))
          .then((value) async {
        print("url data......................");

        url = await value.ref.getDownloadURL();
        print(url);
        if (url.isNotEmpty) {
          geturls.add(url);
        }
        if (geturls.length == 1) {
          await uploaddemopicture(geturls);
        }
        if (geturls.length == 4) {
          print(geturls);
          await upload_to_firebase(geturls);
        }
      });
    });
  }

  uploaddemopicture(List demoimageurl) async {
    print("demo is uploading");

    await FirebaseFirestore.instance
        .collection("Store Products")
        .doc(widget.docid)
        .update({
      "colordemos": FieldValue.arrayUnion([demoimageurl[0]]),
    });
  }

  Future upload_to_firebase(List urllist) async {
    print(
        "here we goooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo");
    await FirebaseFirestore.instance
        .collection("Store Products")
        .doc(widget.docid)
        .collection("Product Colors")
        .add({"color": urllist}).then((value) async {
      await FirebaseFirestore.instance
          .collection("Store Products")
          .doc(widget.docid)
          .update({
        "grandtotalitems": FieldValue.arrayUnion([value.id])
      });
    });
    geturls.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(12),
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              height: 80,
              width: 80,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey)),
              child: Image.asset("assets/Drawing.png"),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Select and modify attributes for the selected item ",
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
            ExpansionTile(
                textColor: Colors.black,
                iconColor: Colors.black,
                title: Text("View image grids"),
                children: [
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("Store Products")
                          .doc(widget.docid)
                          .collection("Product Colors")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        }
                        print("length is  ${snapshot.data!.docs.length}");

                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, superindex) {
                            int grandtotalindex = superindex;

                            return Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                height: 60,
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot curDoc =
                                        snapshot.data!.docs[superindex];
                                    print(index);
                                    return index == 4
                                        ? GestureDetector(
                                            onTap: () async {
                                              await FirebaseFirestore.instance
                                                  .collection("Store Products")
                                                  .doc(widget.docid)
                                                  .collection("Product Colors")
                                                  .doc(curDoc.id)
                                                  .delete();
                                              await FirebaseFirestore.instance
                                                  .collection("Store Products")
                                                  .doc(widget.docid)
                                                  .update({
                                                "colordemos":
                                                    FieldValue.arrayRemove([
                                                  curDoc.get("color")[0]
                                                ]),
                                                "grandtotalitems":
                                                    FieldValue.arrayRemove(
                                                        [curDoc.id])
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  shape: BoxShape.circle),
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 7),
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black)),
                                            child: Image.network(
                                              curDoc.get("color")[index],
                                              fit: BoxFit.fill,
                                            ),
                                            // child: Image.file(
                                            //   File(grandtotalimagesset[
                                            //           grandtotalindex][index]
                                            //       .path),
                                            //   fit: BoxFit.fill,
                                            // ),
                                          );
                                  },
                                ));
                          },
                        );
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  pickimages(),
                ]),
            fields("product name", productname, "product name"),
            SizedBox(
              height: 15,
            ),
            fields("product price", productprice, "product price"),
            SizedBox(
              height: 15,
            ),
            fields("product description", itemdescription, "item description"),
            SizedBox(
              height: 15,
            ),
            fields("product code", productcode, "product code"),
            SizedBox(
              height: 15,
            ),
            // fields("product size", productsize, "product size"),
            // SizedBox(
            //   height: 15,
            // ),
            // fields("product width", productwidth, "product width"),
            // SizedBox(
            //   height: 15,
            // ),
            // fields("product height", productheight, "product height"),
            // SizedBox(
            //   height: 15,
            // ),
            // fields("product fabric", productfabic, "product height"),
            SizedBox(
              height: 15,
            ),
            fields("product inventory", totalinventory, "product height"),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}

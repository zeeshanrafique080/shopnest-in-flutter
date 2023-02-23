import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:adminwallpaper/Screens/upload_modify_delete_products/ProductScreenViews/ProductDescription.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:images_picker/images_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ndialog/ndialog.dart';

class SelectPhoto extends StatefulWidget {
  String docid;
  SelectPhoto({Key? key, required this.docid}) : super(key: key);

  @override
  _SelectPhotoState createState() => _SelectPhotoState();
}

class _SelectPhotoState extends State<SelectPhoto> {
  var random = new Random();
  int imagecount = 0;
  bool loading = false;
  List<String> geturls = [];
  List<Media> selectedimages = [];
  List<List> grandtotal = [];
  int? numberofcolor = 0;
  List<List> grandtotalimagesset = [];
  List<List> grandtotalimagesurl = [];
  List emptyarray = [];
  List<String> adding_url = [];
  Timer intervals = Timer(Duration(seconds: 0), () {});
  int o = 0;
  List demourls = [];
  late bool returntomenu;
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
    setState(() {
      loading = false;
    });
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
          uploaddemopicture(geturls);
        }
        if (geturls.length == 4) {
          print(geturls);
          upload_to_firebase(geturls);
        }
      });
    });
  }

  Widget pickimages() {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black)),
        onPressed: () async {
          if (!loading) {
            setState(() {
              loading = true;
            });
            o++;
            await ImagesPicker.pick(count: 4, pickType: PickType.image)
                .then((value) {
              setState(() {
                selectedimages = value!;
                grandtotalimagesset.add(selectedimages);
              });
            });

            if (selectedimages.length == 4) {
              await upload_to_storage();
              print("the value of o is increasing");
            }
          }
        },
        child: loading
            ? Container(
                height: 12,
                width: 12,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ))
            : Text(
                "pick image",
                style: TextStyle(),
              ));
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
          child: ListView(
            children: [
              SizedBox(height: 30),
              Text(
                "Time to select images",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Select 4 images for each color \n you can add multiple colors \n for the same product & their images",
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
              SizedBox(
                height: 15,
              ),

              // : Image.file(File(selectedimages.first.path));

              // ElevatedButton(
              //     onPressed: () {
              //       print("here are the urls");
              //       if (geturls.isNotEmpty) {
              //         geturls.forEach((element) {
              //           print(element);
              //         });
              //         print(geturls.length);
              //       }
              //     },
              //     child: Text("result")),
              SizedBox(
                height: 20,
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
                                                setState(() {
                                                  grandtotalimagesset.removeAt(
                                                      grandtotalindex);
                                                });

                                                await FirebaseFirestore.instance
                                                    .collection(
                                                        "Store Products")
                                                    .doc(widget.docid)
                                                    .collection(
                                                        "Product Colors")
                                                    .doc(curDoc.id)
                                                    .delete();
                                                await FirebaseFirestore.instance
                                                    .collection(
                                                        "Store Products")
                                                    .doc(widget.docid)
                                                    .update({
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
              Divider(
                color: Colors.black,
              ),
              SizedBox(
                height: 20,
              ),
              // Text("total number of colors ${grandtotalimagesset.length}"),
              // SizedBox(
              //   height: 40,
              // ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProductDescription(docid: widget.docid)));
                },

                // onTap: () async {
                //   if (grandtotalimagesset.isNotEmpty &&
                //       grandtotalimagesurl.isNotEmpty) {
                //     for (int i = 1; i <= grandtotalimagesurl.length; i++) {
                //       await FirebaseFirestore.instance
                //           .collection("Store Products")
                //           .doc(widget.docid)
                //           .update(
                //               {"Product color $i": grandtotalimagesurl[i - 1]});

                //       // print(grandtotalimagesurl[1].length);

                //       await Timer(Duration(seconds: 5), () {
                //         print("entry gone");
                //         print(i);
                //       });
                //     }

                //     // intervals = Timer.periodic(Duration(seconds: 4), (t) {
                //     //   upload_to_firebase();
                //     // });
                //     // intervals.isActive;
                //     // await FirebaseFirestore.instance
                //     //     .collection("Store Products")
                //     //     .doc(widget.docid)
                //     //     .set({"Product images": grandtotalimagesurl}).then(
                //     //         (value) {
                //     //   Navigator.push(
                //     //       context,
                //     //       MaterialPageRoute(
                //     //           builder: (context) =>
                //     //               ProductDescription(docid: widget.docid)));
                //     // });
                //   } else {
                //     print("add photos first");
                //   }
                // },

                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      "Next",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

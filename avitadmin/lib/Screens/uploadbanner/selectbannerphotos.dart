import 'dart:io';
import 'dart:math';

import 'package:adminwallpaper/Screens/MainMenuScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:images_picker/images_picker.dart';

class SelectBannerPhoto extends StatefulWidget {
  const SelectBannerPhoto({Key? key}) : super(key: key);

  @override
  _SelectBannerPhotoState createState() => _SelectBannerPhotoState();
}

class _SelectBannerPhotoState extends State<SelectBannerPhoto> {
  List<String> bannerimagesurl = [];
  var random = new Random();
  bool loading = false;
  uploadtocloud(List urls) async {
    print("uploading to cloud");
    await FirebaseFirestore.instance
        .collection("banners")
        .doc("bannerimageurls")
        .set({"imageurl": urls}).then((value) {
      bannerimagesurl.clear();
      setState(() {
        loading = true;
      });
      final snackBar =
          SnackBar(content: Text('banner are uploaded to the store'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainMenuScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
              child: Image.asset("assets/testingAvit.jpg"),
            ),
            Divider(
              color: Colors.grey,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Banner photos selection",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "select 3 photos that you want \n to show on the landing screen of your app",
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    loading = true;
                  });
                  ImagesPicker.pick(
                          count: 3, pickType: PickType.image, gif: false)
                      .then((value) {
                    if (value!.length == 3) {
                      value.forEach((element) {
                        String chlidref = random.nextInt(1000000).toString();
                        String url = "";
                        FirebaseStorage.instance
                            .ref("AvitRef")
                            .child("$chlidref" + "images/profile" + ".jpg")
                            .putFile(File(element.path))
                            .then((value) async {
                          print("url data......................");

                          url = await value.ref.getDownloadURL();
                          bannerimagesurl.add(url);

                          if (bannerimagesurl.length == 3) {
                            uploadtocloud(bannerimagesurl);
                          }
                        });
                      });
                    }
                  });
                },
                child: loading
                    ? Container(
                        height: 13,
                        width: 13,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Text("pick images"))
          ],
        ),
      ),
    );
  }
}

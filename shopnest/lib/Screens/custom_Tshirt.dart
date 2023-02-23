import 'dart:io';
import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:images_picker/images_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CustomizeTshirt extends StatefulWidget {
  const CustomizeTshirt({Key? key,}) : super(key: key);

  @override
  State<CustomizeTshirt> createState() => _CustomizeTshirtState();
}

class _CustomizeTshirtState extends State<CustomizeTshirt> {
  final customername = TextEditingController();
  final item_description_con = TextEditingController();
  final Shirtchestsize = TextEditingController();
  final TshirtSoulders = TextEditingController();
  final TshirtColur_size = TextEditingController();
  final phoneno_con = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  var random = new Random();
  String url = "";
  File? imageaddress;
  LatLng? currentlocation;

 


  uploadimage() {
    String chlidref = random.nextInt(1000000).toString();
    FirebaseStorage.instance
        .ref("AvitRef")
        .child("${chlidref} image" + ".jpg")
        .putFile(File(imageaddress!.path))
        .then((value) async {
      print("image is successfully uploaded");
      url = await value.ref.getDownloadURL();
      print(url);
    });
  }

  Widget email_field(TextEditingController controller, hinttext, type) {
    return TextFormField(
      // selectionWidthStyle: BoxWidthStyle.tight,
      validator: (value) {
        if (value!.isEmpty) {
          return "must enter email here";
        }
      },
      keyboardType: type == "phone" ? TextInputType.number : TextInputType.text,
      controller: controller,
      //keyboardType: TextInputType.number,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.black, fontSize: 15),
      decoration: InputDecoration(
        filled: true,
        label: Text(hinttext.toString(),
            style: TextStyle(color: Colors.black, fontSize: 22)),
        // labelStyle: TextStyle(
        //   color: kPrimaryColor,
        //   fontSize: 12,
        // ),
        contentPadding:
            const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(25.7),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(25.7),
        ),
      ),
    );
  }

  cameradialog() {
    AwesomeDialog(
      context: context,
      dialogBackgroundColor: Colors.black,
      dialogType: DialogType.SUCCES,
      borderSide: BorderSide(color: Colors.blue[900]!, width: 2),
      width: 380,
      buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
      headerAnimationLoop: false,
      animType: AnimType.BOTTOMSLIDE,
      body: Column(
        children: [
          Text('Select the source of the image',
              style: TextStyle(
                  color: Colors.orange, fontFamily: "new", fontSize: 12)),
        ],
      ),
      btnOkText: "camera",
      btnCancelText: "Gallery",
      showCloseIcon: true,
      btnCancelOnPress: () {
        ImagesPicker.pick(
          quality: 1,
          pickType: PickType.image,
        ).then((value) async {
          //           File compressedFile = await FlutterNativeImage.compressImage(value!.first.path,
          // quality: 90,targetHeight: 600,targetWidth: 400);
          setState(() {
            imageaddress = File(value!.first.path);
          });
          uploadimage();
        });
      },
      btnOkOnPress: () {
        ImagesPicker.openCamera(
                quality: 1,
                pickType: PickType.image,
                cropOpt: CropOption(aspectRatio: CropAspectRatio.wh2x1))
            .then((value) {
          setState(() {
            imageaddress = File(value!.first.path);
          });
          uploadimage();
        });
      },
    )..show();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Customize',
            style: TextStyle(
                color: Colors.black, fontFamily: "lobster", fontSize: 18)),
      ),
      body: Container(
          height: size.height,
          width: size.width,
          color: Colors.white,
          child: ListView(
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Select sample photo',
            style: TextStyle(
                    color: Colors.black, fontFamily: "lobster", fontSize: 15)),
                ],
              ),
              SizedBox(height: 10,),
              Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 18, right: 18),
                        child: GestureDetector(
                          onTap: (() {
                            cameradialog();
                          }),
                          child: Container(
                            height: size.height / 4,
                            width: size.width,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black),
                            ),
                            child: imageaddress == null
                                ? Center(
                                    child: Icon(Icons.add_a_photo,
                                        color: Colors.black, size: 45),
                                  )
                                : Image.file(imageaddress!, fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      email_field(
                          customername, "Your name", "item_name"),
                      SizedBox(
                        height: 14,
                      ),
                      email_field(
                          Shirtchestsize, "Enter Chest Size", "item_name"),
                      SizedBox(
                        height: 14,
                      ),
                      email_field(
                          TshirtSoulders, "Enter Shoulder size", "item_name"),
                      SizedBox(
                        height: 14,
                      ),
                      email_field(
                          TshirtColur_size, "Enter collar size", "item_name"),
                      SizedBox(
                        height: 14,
                      ),
                      email_field(item_description_con,
                          "Enter Shirt description", "item_name"),
                      SizedBox(
                        height: 14,
                      ),
                      email_field(phoneno_con, "contact #", "phone"),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 34,
                      ),
                      GestureDetector(
                        onTap: (() {
                          if (url != "") {
                            if (_formkey.currentState!.validate()) {
                              final auction_item_obj = {
                                "status": "pending",
                                "image link": url.toString(),
                                "chest size":
                                    Shirtchestsize.text.toString().trim(),
                                "Shoulders size":
                                    TshirtSoulders.text.toString().trim(),
                                "collar size":
                                    TshirtColur_size.text.toString().trim(),
                                "customer name":
                                    customername.text.toString().trim(),
                                "item description":
                                    item_description_con.text.toString().trim(),
                                "customer contact number":
                                    phoneno_con.text.toString().trim(),
                                "uploading date":
                                    "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                                "uploading time":
                                    "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}",
                              };
                              FirebaseFirestore.instance
                                  .collection("customize orders")
                                  .add(auction_item_obj)
                                  .then((value) {
                                  Shirtchestsize.clear();
                                  TshirtColur_size.clear();
                                  TshirtSoulders.clear();
                                  
                                customername.clear();
                                item_description_con.clear();
                                phoneno_con.clear();

                                Fluttertoast.showToast(
                                    msg: "order is successfully placed. you will be notified soon",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.amber,
                                    textColor: Colors.black,
                                    fontSize: 16.0);
                              });
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg: "select the image to proceed",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.amber,
                                textColor: Colors.black,
                                fontSize: 16.0);
                          }

                          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Sign_in_screen(),));
                        }),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            height: 50,
                            width: size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(color: Colors.black),
                                color: Colors.black),
                            child: Center(
                              child: Text(
                                "upload",
                                style: TextStyle(
                                  fontFamily: "new",
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,)
                    ],
                  ))
            ],
          )),
    );
  }
}

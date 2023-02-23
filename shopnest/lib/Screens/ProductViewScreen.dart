import 'package:shopnest/Models/Delivery&Return.dart';
import 'package:shopnest/Models/StreamBuilders.dart';
import 'package:shopnest/Models/StreamSimilaritems.dart';
import 'package:shopnest/examples/mainar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../examples/objectsonplanesexample.dart';

class ProductViewScreen extends StatefulWidget {
  final String catagoryname;
  final String subcatagoryname;
  final String docid;
  final List imagedocs;
  final String productname;
  final String productprice;
  final String productdescription;
  final String productcode;
  final String fabricdetails;
  final String productsize;
  final String productwidth;
  final String productheight;
  final String herotag;
  final String totalinventory;

  ProductViewScreen(
      {Key? key,
      required this.catagoryname,
      required this.subcatagoryname,
      required this.totalinventory,
      required this.docid,
      required this.imagedocs,
      required this.fabricdetails,
      required this.productcode,
      required this.productdescription,
      required this.productheight,
      required this.productname,
      required this.productprice,
      required this.productsize,
      required this.herotag,
      required this.productwidth})
      : super(key: key);

  @override
  _ProductViewScreenState createState() => _ProductViewScreenState();
}

class _ProductViewScreenState extends State<ProductViewScreen> {
  bool showdetails = true;
  bool showdelivery = false;
  bool showpayment = false;
  List image_colors_address = [];
  List imagedataofeachdoc = [];
  List<List> grandtotalimages = [];
  int firstindex = 0;
  List<bool> selectedborderindex = [];
  int prevselectedborderindex = 0;
  List<bool> listofindicators = [];
  int prevselectedindicatorindex = 0;
  CarouselController carouselController = CarouselController();
  String countrysizeselector = "US";
  bool disablebutton = false;
  String setsizestream = 'Us size';
  @override
  void initState() {
    super.initState();
  }

  Widget showsimilaritems() {
    print(widget.catagoryname);
    print(widget.subcatagoryname);
    return StreamSimilarItems(
      catagaoryname: widget.catagoryname,
      subcatagoryname: widget.subcatagoryname,
      productcode: widget.productcode,
      crosscountaxis: 1,
      gridlength: 4,
      size: 1.4,
      scrollphysics: AlwaysScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
    );
  }

  Widget sizefuntion(int size) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 0),
      margin: EdgeInsets.only(left: 9),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle, border: Border.all(color: Colors.grey)),
      child: Center(
        child: Text("$size"),
      ),
    );
  }

  Widget ifdetails(item_name, itemdescription, productcode, fabric_details,
      product_size, product_width, productheight) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "$item_name",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 9,
        ),
        Row(
          children: [
            Text(
              "$itemdescription",
            ),
          ],
        ),
        SizedBox(
          height: 6,
        ),
        Row(
          children: [
            Text(
              "Product Code : ",
            ),
            Text(
              "$productcode",
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text(
              "Fabric Details",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 9,
        ),
        Row(
          children: [
            Text(
              "$fabric_details",
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        // Row(
        //   children: [
        //     Text(
        //       "Product Measurements on image",
        //       style: TextStyle(
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //   ],
        // ),
        // SizedBox(
        //   height: 9,
        // ),
        // Row(
        //   children: [
        //     Text(
        //       "Size : ",
        //     ),
        //     Text(
        //       "$product_size",
        //     ),
        //   ],
        // ),
        // SizedBox(
        //   height: 6,
        // ),
        // Row(
        //   children: [
        //     Text(
        //       "Width : ",
        //     ),
        //     Text(
        //       "$product_width",
        //     ),
        //   ],
        // ),
        // SizedBox(
        //   height: 6,
        // ),
        // Row(
        //   children: [
        //     Text(
        //       "Height : ",
        //     ),
        //     Text(
        //       "$productheight",
        //     ),
        //   ],
        // ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: ListView(
            children: [
              SizedBox(
                height: 35,
              ),

              Row(
                children: [
                  SizedBox(
                    width: 13,
                  ),
                  StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("Store Products")
                        .doc(widget.docid)
                        .collection("Product Colors")
                        .doc(widget.imagedocs[firstindex])
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text("");
                      }
                      DocumentSnapshot curDoc = snapshot.data!;
                      return Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                  height: 260,
                                  width: 210,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: CarouselSlider.builder(
                                    carouselController: carouselController,
                                    options: CarouselOptions(
                                      pauseAutoPlayOnTouch: true,
                                      height: 230,
                                      viewportFraction: .9,
                                      enableInfiniteScroll: true,
                                      autoPlay: true,
                                      autoPlayAnimationDuration:
                                          Duration(milliseconds: 800),
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      enlargeCenterPage: true,
                                      scrollDirection: Axis.horizontal,
                                      autoPlayInterval: Duration(seconds: 5),
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          listofindicators[
                                                  prevselectedindicatorindex] =
                                              false;
                                          listofindicators[index] = true;
                                        });
                                        prevselectedindicatorindex = index;
                                      },
                                    ),
                                    itemCount: 4,
                                    itemBuilder: (context, index, realIndex) {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Hero(
                                          tag: widget.herotag,
                                          child: CachedNetworkImage(
                                              filterQuality: FilterQuality.none,
                                              fit: BoxFit.fill,
                                              placeholder: (context, url) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              'assets/download.png'))),
                                                );
                                              },
                                              //net prob
                                              imageUrl:
                                                  curDoc.get("color")[index]),
                                        ),
                                      );
                                    },
                                  )),
                              Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 1, vertical: 3),
                                child: Center(
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: 4,
                                    itemBuilder: (context, index) {
                                      if (index == 0) {
                                        listofindicators.add(true);
                                      } else {
                                        listofindicators.add(false);
                                      }

                                      return AnimatedContainer(
                                        duration: Duration(milliseconds: 300),
                                        margin: EdgeInsets.only(right: 4),
                                        height: 5,
                                        width: 5,
                                        decoration: BoxDecoration(
                                          color: listofindicators[index]
                                              ? Colors.orange
                                              : Colors.grey,
                                          shape: BoxShape.circle,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Container(
                            height: 270,
                            width: 70,
                            child: Column(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: 3,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        carouselController
                                            .animateToPage(index + 1);
                                      },
                                      child: Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: CachedNetworkImage(
                                              height: 75,
                                              width: 40,
                                              filterQuality: FilterQuality.none,
                                              fit: BoxFit.fill,
                                              placeholder: (context, url) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              'assets/download.png'))),
                                                );
                                              },
                                              //net prob
                                              imageUrl: curDoc
                                                  .get("color")[index + 1]),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    width: 17,
                  ),
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Container(
              //       padding: EdgeInsets.all(6),
              //       decoration: BoxDecoration(
              //           border: Border.all(color: Colors.black, width: .3),
              //           borderRadius: BorderRadius.circular(12)),
              //       child: GestureDetector(
              //         onTap: () {
              //           Navigator.of(context).push(
              //             MaterialPageRoute(
              //               builder: (context) => ObjectsOnPlanesWidget(),
              //             ),
              //           );
              //         },
              //         child: Text(
              //           "check through Vr",
              //           style: TextStyle(
              //               fontSize: 13,
              //               fontWeight: FontWeight.bold,
              //               color: Colors.green),
              //         ),
              //       ),
              //     )
              //   ],
              // ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.productname,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.productdescription,
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "PKR " + widget.productprice,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              // SizedBox(
              //   height: 5,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Icon(
              //       Icons.star,
              //       color: Colors.amber,
              //     ),
              //     Icon(
              //       Icons.star,
              //       color: Colors.amber,
              //     ),
              //     Icon(
              //       Icons.star,
              //       color: Colors.amber,
              //     ),
              //     Icon(
              //       Icons.star,
              //       color: Colors.amber,
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     Container(
              //       padding: EdgeInsets.all(3),
              //       child: Text(
              //         "Color",
              //         style: TextStyle(
              //             color: Colors.black, fontWeight: FontWeight.bold),
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // Container(
              //   height: 45,
              //   padding: EdgeInsets.only(left: 12, right: 12),
              //   child: StreamBuilder<DocumentSnapshot>(
              //       stream: FirebaseFirestore.instance
              //           .collection("Store Products")
              //           .doc(widget.docid)
              //           .snapshots(),
              //       builder: (context, snapshot) {
              //         if (!snapshot.hasData) {
              //           return Center(child: CircularProgressIndicator());
              //         }
              //         DocumentSnapshot curDoc = snapshot.data!;
              //         return widget.imagedocs.length ==
              //                 curDoc.get("colordemos").length
              //             ? ListView.builder(
              //                 scrollDirection: Axis.horizontal,
              //                 itemCount: curDoc.get("colordemos").length,
              //                 itemBuilder: (context, index) {
              //                   if (index == 0) {
              //                     selectedborderindex.add(true);
              //                   } else {
              //                     selectedborderindex.add(false);
              //                   }

              //                   return AnimationConfiguration.staggeredList(
              //                     position: index,
              //                     duration: const Duration(milliseconds: 575),
              //                     child: SlideAnimation(
              //                       curve: Curves.easeOutSine,
              //                       verticalOffset: 50.0,
              //                       child: GestureDetector(
              //                         onTap: () {
              //                           setState(() {
              //                             firstindex = index;

              //                             selectedborderindex[
              //                                 prevselectedborderindex] = false;
              //                             selectedborderindex[index] = true;
              //                           });
              //                           prevselectedborderindex = index;
              //                         },
              //                         child: Container(
              //                           margin: EdgeInsets.only(left: 15),
              //                           width: 33,
              //                           decoration: BoxDecoration(
              //                               shape: BoxShape.rectangle,
              //                               border: Border.all(
              //                                   color: selectedborderindex[
              //                                               index] ==
              //                                           false
              //                                       ? Colors.black
              //                                       : Colors.red)),
              //                           child: ClipRRect(
              //                             child: CachedNetworkImage(
              //                                 filterQuality: FilterQuality.none,
              //                                 fit: BoxFit.fill,
              //                                 placeholder: (context, url) {
              //                                   return Container(
              //                                     decoration: BoxDecoration(
              //                                         image: DecorationImage(
              //                                             image: AssetImage(
              //                                                 'assets/download.png'))),
              //                                   );
              //                                 },
              //                                 //net prob
              //                                 imageUrl: curDoc
              //                                     .get("colordemos")[index]),
              //                           ),
              //                         ),
              //                       ),
              //                     ),
              //                   );
              //                 },
              //               )
              //             : CircularProgressIndicator();
              //       }),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // Row(
              //   children: [
              //     Column(
              //       children: [
              //         Text(
              //           "Size",
              //           style: TextStyle(
              //               color: Colors.black, fontWeight: FontWeight.bold),
              //         ),
              //       ],
              //     ),
              //     SizedBox(
              //       width: 25,
              //     ),
              //     Column(
              //       children: [
              //         GestureDetector(
              //           onTap: () {
              //             setState(() {
              //               countrysizeselector = "US";
              //               setsizestream = "Us size";
              //             });
              //           },
              //           child: Text(
              //             "US",
              //             style: TextStyle(
              //               color: Colors.black,
              //               fontWeight: FontWeight.bold,
              //             ),
              //           ),
              //         ),
              //         countrysizeselector != "US" ? Text("") : Text("____")
              //       ],
              //     ),
              //     SizedBox(
              //       width: 25,
              //     ),
              //     Column(
              //       children: [
              //         GestureDetector(
              //           onTap: () {
              //             setState(() {
              //               countrysizeselector = "EU";
              //               setsizestream = "Uk size";
              //             });
              //           },
              //           child: Text(
              //             "EU",
              //             style: TextStyle(
              //                 color: Colors.black, fontWeight: FontWeight.bold),
              //           ),
              //         ),
              //         countrysizeselector == "US" ? Text("") : Text("____")
              //       ],
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // Container(
              //     height: 50,
              //     child: StreamBuilder<DocumentSnapshot>(
              //       stream: FirebaseFirestore.instance
              //           .collection("Store Products")
              //           .doc(widget.docid)
              //           .snapshots(),
              //       builder: (context, snapshot) {
              //         if (!snapshot.hasData) {
              //           return Container(
              //             height: 30,
              //             child: Center(
              //               child: CircularProgressIndicator(
              //                 color: Colors.grey,
              //               ),
              //             ),
              //           );
              //         }

              //         return ListView.builder(
              //           scrollDirection: Axis.horizontal,
              //           itemCount: snapshot.data!.get(setsizestream).length,
              //           itemBuilder: (context, index) {
              //             return Container(
              //               padding: EdgeInsets.symmetric(
              //                   horizontal: 7, vertical: 0),
              //               margin: EdgeInsets.only(left: 9),
              //               decoration: BoxDecoration(
              //                   shape: BoxShape.rectangle,
              //                   border: Border.all(color: Colors.grey)),
              //               child: Center(
              //                 child: Text(
              //                     snapshot.data!.get(setsizestream)[index]),
              //               ),
              //             );
              //           },
              //         );
              //       },
              //     )

              // ListView(
              //   scrollDirection: Axis.horizontal,
              //   children: [
              //     sizefuntion(6),
              //     SizedBox(
              //       width: 12,
              //     ),
              //     sizefuntion(8),
              //     SizedBox(
              //       width: 12,
              //     ),
              //     sizefuntion(10),
              //     SizedBox(
              //       width: 12,
              //     ),
              //     sizefuntion(12),
              //     SizedBox(
              //       width: 12,
              //     ),
              //     sizefuntion(14),
              //     SizedBox(
              //       width: 12,
              //     ),
              //     sizefuntion(16),
              //   ],
              // ),
//                  ),
              // SizedBox(
              //   height: 20,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Container(
              //       padding: EdgeInsets.all(20),
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(20),
              //           border: Border.all(color: Colors.grey)),
              //       child: Row(
              //         children: [
              //           Icon(
              //             Icons.bus_alert_outlined,
              //             color: Colors.red,
              //           ),
              //           SizedBox(
              //             width: 20,
              //           ),
              //           Column(
              //             children: [
              //               Text("Estimated Delivery time :"),
              //               SizedBox(
              //                 height: 7,
              //               ),
              //               Text("10 - 12 days")
              //             ],
              //           )
              //         ],
              //       ),
              //     )
              //   ],
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // Container(
              //   height: 50,
              //   child: ListView(
              //     scrollDirection: Axis.horizontal,
              //     children: [
              //       Column(
              //         children: [
              //           GestureDetector(
              //             onTap: () {
              //               setState(() {
              //                 showdetails = true;
              //                 showpayment = false;
              //                 showdelivery = false;
              //               });
              //             },
              //             child: Text(
              //               "Details",
              //               style: TextStyle(
              //                   fontWeight: FontWeight.bold, fontSize: 12),
              //             ),
              //           ),
              //           showdetails
              //               ? Text(
              //                   "_____",
              //                   style: TextStyle(
              //                       fontWeight: FontWeight.bold, fontSize: 12),
              //                 )
              //               : Container(),
              //         ],
              //       ),
              //       SizedBox(
              //         width: 5,
              //       ),
              //       Text("|"),
              //       SizedBox(
              //         width: 5,
              //       ),
              //       Column(
              //         children: [
              //           GestureDetector(
              //             onTap: () {
              //               setState(() {
              //                 showdetails = false;
              //                 showpayment = false;
              //                 showdelivery = true;
              //               });
              //             },
              //             child: Text(
              //               "Delivery & return",
              //               style: TextStyle(
              //                   fontWeight: FontWeight.bold, fontSize: 12),
              //             ),
              //           ),
              //           showdelivery
              //               ? Text(
              //                   "_____",
              //                   style: TextStyle(
              //                       fontWeight: FontWeight.bold, fontSize: 12),
              //                 )
              //               : Container(),
              //         ],
              //       ),
              //       SizedBox(
              //         width: 5,
              //       ),
              //       Text("|"),
              //       SizedBox(
              //         width: 5,
              //       ),
              //       Column(
              //         children: [
              //           GestureDetector(
              //             onTap: () {
              //               setState(() {
              //                 showdetails = false;
              //                 showpayment = true;
              //                 showdelivery = false;
              //               });
              //             },
              //             child: Text(
              //               "payments & installments",
              //               style: TextStyle(
              //                   fontWeight: FontWeight.bold, fontSize: 12),
              //             ),
              //           ),
              //           showpayment
              //               ? Text(
              //                   "_____",
              //                   style: TextStyle(
              //                       fontWeight: FontWeight.bold, fontSize: 12),
              //                 )
              //               : Container(),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              // showdetails && !showpayment
              //     ? ifdetails(
              //         widget.productname,
              //         widget.productdescription,
              //         widget.productcode,
              //         widget.fabricdetails,
              //         widget.productsize,
              //         widget.productwidth,
              //         widget.productheight)
              //     : showdelivery && !showpayment
              //         ? DeliveryReturn()
              //         : Container(),

              //if payments & if delivery is left behind to code
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      final snackBar = SnackBar(content: Text('added to cart'));

                      if (await FirebaseAuth.instance.currentUser != null &&
                          int.tryParse(widget.totalinventory)! > 0 &&
                          disablebutton == false) {
                        setState(() {
                          disablebutton = true;
                        });
                        await FirebaseFirestore.instance
                            .collection("Consumers")
                            .doc(FirebaseAuth.instance.currentUser!.uid
                                .toString())
                            .collection("My Bag")
                            .where("product_doc_id", isEqualTo: widget.docid)
                            .get()
                            .then((value) async {
                          if (value.docs.length != null &&
                              value.docs.length > 0 &&
                              value.docs.length < 2) {
                            print("already listed in stock");
                          } else {
                            await FirebaseFirestore.instance
                                .collection("Consumers")
                                .doc(FirebaseAuth.instance.currentUser!.uid
                                    .toString())
                                .collection("My Bag")
                                .add({
                              "purchase_quantity": "1",
                              "product_image": widget.herotag,
                              "product_name": widget.productname,
                              "product_price": widget.productprice,
                              "product_short description":
                                  widget.productdescription,
                              "product_doc_id": widget.docid
                            });
                            int tempsum, grandsum = 0;
                            await FirebaseFirestore.instance
                                .collection("Consumers")
                                .doc(FirebaseAuth.instance.currentUser!.uid
                                    .toString())
                                .get()
                                .then((value) async {
                              tempsum = int.tryParse(value.get("temp sum"))!;
                              grandsum =
                                  int.tryParse(widget.productprice)! + tempsum;
                              await FirebaseFirestore.instance
                                  .collection("Consumers")
                                  .doc(FirebaseAuth.instance.currentUser!.uid
                                      .toString())
                                  .update({"temp sum": grandsum.toString()});
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            });
                          }
                        });
                      } else {
                        print("no user or out of stock");
                      }
                      setState(() {
                        disablebutton = false;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 35, right: 35, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.black,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_bag_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          disablebutton
                              ? Container(
                                  height: 15,
                                  width: 15,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ))
                              : Text(
                                  "Add to Bag",
                                  style: TextStyle(color: Colors.white),
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // SizedBox(
              //   height: 25,
              // ),
              // Text(
              //   "Similar Products",
              //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              // ),
              // SizedBox(
              //   height: 15,
              // ),
              // Container(height: 300, child: showsimilaritems())
            ],
          )),
    );
  }
}

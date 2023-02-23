import 'package:shopnest/Screens/ProductViewScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:favorite_button/favorite_button.dart';

class StreamSimilarItems extends StatefulWidget {
  final String catagaoryname;
  final String subcatagoryname;
  final String productcode;
  final Axis scrollDirection;
  final int gridlength;
  final double size;
  final ScrollPhysics scrollphysics;
  final int crosscountaxis;
  const StreamSimilarItems(
      {Key? key,
      required this.gridlength,
      required this.size,
      required this.productcode,
      required this.catagaoryname,
      required this.subcatagoryname,
      required this.scrollphysics,
      required this.scrollDirection,
      required this.crosscountaxis})
      : super(key: key);

  @override
  _StreamBuilderState createState() => _StreamBuilderState();
}

class _StreamBuilderState extends State<StreamSimilarItems> {
  final mauth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("Store Products")
          //.where("product code", isNotEqualTo: widget.productcode)
          // .where("item catagory", isEqualTo: widget.catagaoryname.toString())
          .where("item sub_catagory",
              isEqualTo: widget.subcatagoryname.toString())
          .where("Ready to Display", isEqualTo: "true")
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        return GridView.builder(
            shrinkWrap: true,
            scrollDirection: widget.scrollDirection,
            physics: widget.scrollphysics,
            itemCount: snapshot.data!.docs.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: widget.size,
                //  (MediaQuery.of(context).size.width /1.2) /
                //     (MediaQuery.of(context).size.height / 2.7),
                mainAxisSpacing: 13,
                crossAxisSpacing: 18,
                crossAxisCount: widget.crosscountaxis),
            itemBuilder: (context, index) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              DocumentSnapshot curDoc = snapshot.data!.docs[index];

              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 575),
                child: SlideAnimation(
                    curve: Curves.fastLinearToSlowEaseIn,
                    verticalOffset: 50.0,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 400),
                      // decoration: BoxDecoration(
                      //     border: Border.all(color: Colors.black),
                      //     borderRadius: BorderRadius.circular(25)),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(1.0, -3.0),
                                blurRadius: 1.7,
                                spreadRadius: .8,
                                color: Colors.grey),
                          ]),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductViewScreen(
                                            catagoryname: widget.catagaoryname,
                                            subcatagoryname:
                                                widget.subcatagoryname,
                                            totalinventory:
                                                curDoc.get('product_inventory'),
                                            imagedocs:
                                                curDoc.get('grandtotalitems'),
                                            herotag:
                                                curDoc.get('colordemos')[0],
                                            docid: curDoc.id,
                                            fabricdetails:
                                                curDoc.get('fabric details'),
                                            productcode:
                                                curDoc.get('product code'),
                                            productdescription:
                                                curDoc.get('item description'),
                                            productheight:
                                                curDoc.get('product height'),
                                            productname:
                                                curDoc.get('product name'),
                                            productprice:
                                                curDoc.get('product price'),
                                            productsize:
                                                curDoc.get('product size'),
                                            productwidth:
                                                curDoc.get('product width'),
                                          )));
                            },
                            child: Container(
                              height: 160,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Hero(
                                  tag: curDoc.get('colordemos')[0],
                                  child: CachedNetworkImage(
                                      filterQuality: FilterQuality.low,
                                      fit: BoxFit.fill,
                                      height: double.maxFinite,
                                      width: double.maxFinite,
                                      placeholder: (context, url) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/splash.PNG'))),
                                        );
                                      },
                                      //net prob
                                      imageUrl: curDoc.get('colordemos')[0]),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(curDoc.get("product name"),
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold)),
                                    Spacer(),
                                    FavoriteButton(
                                      iconSize: 35,
                                      valueChanged: (_isFavorite) {
                                        print(_isFavorite);
                                        if (_isFavorite) {
                                          if (mauth.currentUser != null) {
                                            FirebaseFirestore.instance
                                                .collection("Store Products")
                                                .doc(curDoc.id)
                                                .update({
                                              "liked by": FieldValue.arrayUnion(
                                                  [mauth.currentUser!.uid])
                                            });
                                          }
                                        } else {
                                          if (mauth.currentUser != null) {
                                            FirebaseFirestore.instance
                                                .collection("Store Products")
                                                .doc(curDoc.id)
                                                .update({
                                              "liked by":
                                                  FieldValue.arrayRemove(
                                                      [mauth.currentUser!.uid])
                                            });
                                          }
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      width: 10,
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Lorem ipsum",
                                        style: TextStyle(
                                          fontSize: 12,
                                        )),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(curDoc.get("product price"),
                                        style: TextStyle(
                                          fontSize: 12,
                                        )),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductViewScreen(
                                                  catagoryname:
                                                      widget.catagaoryname,
                                                  subcatagoryname:
                                                      widget.subcatagoryname,
                                                  totalinventory: curDoc
                                                      .get('product_inventory'),
                                                  imagedocs: curDoc
                                                      .get('grandtotalitems'),
                                                  herotag: curDoc
                                                      .get('colordemos')[0],
                                                  docid: curDoc.id,
                                                  fabricdetails: curDoc
                                                      .get('fabric details'),
                                                  productcode: curDoc
                                                      .get('product code'),
                                                  productdescription: curDoc
                                                      .get('item description'),
                                                  productheight: curDoc
                                                      .get('product height'),
                                                  productname: curDoc
                                                      .get('product name'),
                                                  productprice: curDoc
                                                      .get('product price'),
                                                  productsize: curDoc
                                                      .get('product size'),
                                                  productwidth: curDoc
                                                      .get('product width'),
                                                )));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 18, vertical: 4),
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Text(
                                      "view now",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
              );
            });
      },
    );
  }
}

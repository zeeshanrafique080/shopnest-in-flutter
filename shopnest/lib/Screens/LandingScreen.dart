import 'package:shopnest/Models/StreamBuilders.dart';
import 'package:shopnest/Models/streamsugesteditems.dart';
import 'package:shopnest/Screens/ProductViewScreen.dart';
import 'package:shopnest/Screens/ViewAllProducts.dart';
import 'package:shopnest/Screens/dumydata.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  bool avitselected = true;
  bool evikaselected = false;
  String subcatagorySelection = 'landing products';
  List<bool> subcatarecognation = [];
  int subpressedindex = 0;
  Widget first_brand_name(brandname) {
    return GestureDetector(
      onTap: () {
        setState(() {
          avitselected = true;
          evikaselected = false;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        padding: EdgeInsets.symmetric(horizontal: 22, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: .3),
          color: avitselected ? Colors.grey : Colors.white,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Text(brandname.toString()),
      ),
    );
  }

  Widget second_brand_name(brandname) {
    return GestureDetector(
      onTap: () {
        setState(() {
          avitselected = false;
          evikaselected = true;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        padding: EdgeInsets.symmetric(horizontal: 22, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: .3),
          color: evikaselected ? Colors.grey : Colors.white,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Text(brandname.toString()),
      ),
    );
  }

  Widget top_five_brand_name(brandname) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: .3),
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Text(brandname.toString()),
    );
  }

  Widget showitems() {
    return StreamGridbuilder(
      catagaoryname: "trending",
      subcatagoryname: subcatagorySelection,
      crosscountaxis: 2,
      scrollDirection: Axis.vertical,
      gridlength: 4,
      size: .6,
      scrollphysics: NeverScrollableScrollPhysics(),
    );
  }

  Widget showsuggesteditems() {
    return streaamsuggesteditems(
      crosscountaxis: 2,
      scrollDirection: Axis.vertical,
      size: .6,
      scrollphysics: NeverScrollableScrollPhysics(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("banners")
                    .doc("bannerimageurls")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("loading");
                  }
                  return CarouselSlider.builder(
                    itemCount: 3,
                    itemBuilder: (context, index, realIndex) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                            filterQuality: FilterQuality.none,
                            fit: BoxFit.fill,
                            placeholder: (context, url) {
                              return Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage('assets/download.png'))),
                              );
                            },
                            //net prob
                            imageUrl: snapshot.data!.get("imageurl")[index]),
                      );
                    },
                    options: CarouselOptions(
                      height: 400,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Divider(
              color: Colors.black,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Suggested items",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  showsuggesteditems(),
                  SizedBox(
                    height: 20,
                  ),
                  //   Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Icon(Icons.facebook),
                  //       Container(
                  //         height: 38,
                  //         width: 39,
                  //         decoration: BoxDecoration(
                  //             shape: BoxShape.circle,
                  //             image: DecorationImage(
                  //                 image: AssetImage("assets/insta_logo.png"),
                  //                 fit: BoxFit.fill)),
                  //       ),
                  //       Container(
                  //         height: 38,
                  //         width: 33,
                  //         decoration: BoxDecoration(
                  //             shape: BoxShape.circle,
                  //             image: DecorationImage(
                  //                 image: AssetImage("assets/tiktok_logo.png"),
                  //                 fit: BoxFit.fill)),
                  //       ),
                  //       Container(
                  //         height: 34,
                  //         width: 34,
                  //         decoration: BoxDecoration(
                  //             shape: BoxShape.circle,
                  //             image: DecorationImage(
                  //                 image: AssetImage("assets/twiter_logo.png"),
                  //                 fit: BoxFit.fill)),
                  //       ),
                  //     ],
                  //   ),
                  //   Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Container(
                  //         height: 38,
                  //         width: 39,
                  //         decoration: BoxDecoration(
                  //             shape: BoxShape.circle,
                  //             image: DecorationImage(
                  //                 image: AssetImage("assets/whats_app.png"),
                  //                 fit: BoxFit.fill)),
                  //       ),
                  //       Container(
                  //         height: 38,
                  //         width: 39,
                  //         decoration: BoxDecoration(
                  //             shape: BoxShape.circle,
                  //             image: DecorationImage(
                  //                 image: AssetImage("assets/linked_in.png"),
                  //                 fit: BoxFit.fill)),
                  //       ),
                  //       Container(
                  //         height: 35,
                  //         width: 34,
                  //         decoration: BoxDecoration(
                  //             shape: BoxShape.circle,
                  //             image: DecorationImage(
                  //                 image: AssetImage("assets/youtube_logo.png"),
                  //                 fit: BoxFit.fill)),
                  //       ),
                  //       Container(
                  //         height: 35,
                  //         width: 34,
                  //         decoration: BoxDecoration(
                  //             shape: BoxShape.circle,
                  //             image: DecorationImage(
                  //                 image: AssetImage("assets/snapchat_logo.png"),
                  //                 fit: BoxFit.fill)),
                  //       ),
                  //     ],
                  //   )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

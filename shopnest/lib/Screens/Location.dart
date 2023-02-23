import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  List<Marker> _markers = [];
  late GoogleMapController mapscontroller;
  List<GeoPoint> geoPointList = [];
  @override
  void initState() {
    super.initState();
    loadlocation();
  }

  loadlocation() {
    FirebaseFirestore.instance
        .collection("Store Locations")
        .where("show location", isEqualTo: "true")
        .snapshots()
        .forEach((element) {
      element.docs.forEach((element) {
        final GeoPoint point = element.get('location.geopoint');

        _markers.add(Marker(
          markerId: MarkerId(element.id),
          position: LatLng(point.latitude, point.longitude),
          icon: BitmapDescriptor.defaultMarker,
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Store Locations")
                  .where("show location", isEqualTo: "true")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                return ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    Container(
                      height: 180,
                      child: GoogleMap(
                          onMapCreated: (controller) {
                            setState(() {
                              mapscontroller = controller;
                            });
                          },
                          markers: Set<Marker>.of(_markers),
                          mapType: MapType.hybrid,
                          initialCameraPosition: CameraPosition(
                              target: LatLng(31.483256, 36.206820), zoom: 7)),
                    ),
                    Container(
                      height: 280,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot documentSnapshot =
                              snapshot.data!.docs[index];
                          GeoPoint point =
                              documentSnapshot.get('location.geopoint');
                          geoPointList.add(point);
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 975),
                            child: SlideAnimation(
                              curve: Curves.fastLinearToSlowEaseIn,
                              verticalOffset: 50.0,
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  children: [
                                    Divider(
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.directions),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        GestureDetector(
                                          onTap: ()async{
                                            await FlutterPhoneDirectCaller.callNumber(documentSnapshot
                                                    .get("Store number"));
                                          },
                                          child: Icon(Icons.call)),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            mapscontroller.animateCamera(
                                                CameraUpdate.newLatLngZoom(
                                                    LatLng(
                                                        geoPointList[index]
                                                            .latitude,
                                                        geoPointList[index]
                                                            .longitude),
                                                    11));
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                documentSnapshot
                                                    .get("Store name"),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                  documentSnapshot
                                                      .get("Store location"),
                                                  style:
                                                      TextStyle(fontSize: 6)),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                );
              },
            )));
  }
}

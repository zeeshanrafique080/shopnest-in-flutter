import 'package:adminwallpaper/Screens/GoogleMapsHandling/GoogleMapsAddorRemove/AddStoreDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class AddStoreLocation extends StatefulWidget {
  const AddStoreLocation({Key? key}) : super(key: key);

  @override
  _AddStoreLocationState createState() => _AddStoreLocationState();
}

class _AddStoreLocationState extends State<AddStoreLocation> {
  // final _gucontroller = GoogleMapController();
  bool mapToggle = false;
  List<Marker> _markers = <Marker>[];
  late LatLng _latLng;
  // late GeoFirePoint _geoFirePoint;
  // LocationData _locationData;
  // Location location = Location();
  late GeoFirePoint _geoFirePoint;
  taphandler(LatLng pos) {
    setState(() {
      _markers = [];
      _markers.add(Marker(
        markerId: MarkerId(pos.toString()),
        position: LatLng(pos.latitude, pos.longitude),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
    _latLng = pos;
    print(pos.latitude);
    print(pos.longitude);
  }

  savedatatofirebase() async {
    _geoFirePoint = GeoFirePoint(_latLng.latitude, _latLng.longitude);
    if (_geoFirePoint != null && _latLng != null) {
      await FirebaseFirestore.instance
          .collection('Store Locations')
          .add({'location': _geoFirePoint.data}).then((value) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddStoreDetails(docid: value.id),
            ));
      });
    } else {
      print("add location first");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          GoogleMap(
            mapToolbarEnabled: false,
            // myLocationButtonEnabled: false,
            initialCameraPosition: CameraPosition(
              target: LatLng(31.483256, 36.206820),
              zoom: 8.0,
            ),

            mapType: MapType.hybrid,
            zoomControlsEnabled: false,
            compassEnabled: true,
            myLocationEnabled: true,
            markers: Set<Marker>.of(_markers),
            onTap: (argument) {
              taphandler(argument);
            },
          ),
          Positioned(
            bottom: 20,
            right: 40,
            child: ElevatedButton(
              onPressed: () async {
                await savedatatofirebase();
              },
              child: Text(
                'Save & continue',
                style: TextStyle(
                    color: Colors.blue[700],
                    fontFamily: 'LobsterTwo Bold',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2),
              ),
            ),
          )
        ],
      ),
    ));
  }
}

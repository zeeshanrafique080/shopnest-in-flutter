import 'package:adminwallpaper/Screens/GoogleMapsHandling/GoogleMapsAddorRemove/AddLocation.dart';
import 'package:adminwallpaper/Screens/GoogleMapsHandling/GoogleMapsAddorRemove/RemoveStoreLocation.dart';
import 'package:flutter/material.dart';

class GoogleMapsOption extends StatefulWidget {
  const GoogleMapsOption({Key? key}) : super(key: key);

  @override
  _GoogleMapsOptionState createState() => _GoogleMapsOptionState();
}

class _GoogleMapsOptionState extends State<GoogleMapsOption> {
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
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddStoreLocation(),
                      ));
                },
                child: Text("Add Store location")),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RemoveStore(),
                      ));
                },
                child: Text("remove Store location")),
          ],
        ),
      ),
    );
  }
}

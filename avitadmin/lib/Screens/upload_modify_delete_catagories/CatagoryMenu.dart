import 'package:adminwallpaper/Screens/upload_modify_delete_catagories/CatagoryMenu/CreateCatagories.dart';
import 'package:flutter/material.dart';
import 'package:images_picker/images_picker.dart';

import 'CatagoryMenu/DeleteCatagories.dart';
import 'CatagoryMenu/UpgradeExistingCatagory.dart';

class CatagoryMenu extends StatefulWidget {
  const CatagoryMenu({Key? key}) : super(key: key);

  @override
  _CatagoryMenuState createState() => _CatagoryMenuState();
}

class _CatagoryMenuState extends State<CatagoryMenu> {
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
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateCatagories()));
                },
                child: Text("create catagory")),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpgradeExistingCatagory()));
                },
                child: Text("add subcatagory")),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DeleteCatagories()));
                },
                child: Text("Delete catagories"))
          ],
        ),
      ),
    );
  }
}

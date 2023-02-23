import 'package:adminwallpaper/Screens/upload_modify_delete_products/ProductScreenViews/SelectCatagoriesScreen.dart';
import 'package:adminwallpaper/Screens/upload_modify_delete_products/ProductScreenViews/ViewProductsScreen.dart';
import 'package:flutter/material.dart';

class ProductMainMenu extends StatefulWidget {
  const ProductMainMenu({Key? key}) : super(key: key);

  @override
  _ProductMainMenuState createState() => _ProductMainMenuState();
}

class _ProductMainMenuState extends State<ProductMainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddProductScreen()));
              },
              child: Text("upload product",
                  style: TextStyle(
                    color: Colors.red,
                  )),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewProductsScreen()));
                },
                child: Text("Modify or Delete")),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

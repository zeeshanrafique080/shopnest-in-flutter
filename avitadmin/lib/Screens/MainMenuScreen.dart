import 'package:adminwallpaper/Screens/GoogleMapsHandling/GoogleMapsOption.dart';
import 'package:adminwallpaper/Screens/ManageOrerList/OrderListMenu.dart';
import 'package:adminwallpaper/Screens/customizeorders.dart';
import 'package:adminwallpaper/Screens/manage%20rider/riders.dart';
import 'package:adminwallpaper/Screens/managecustomer/AllCustomers.dart';
import 'package:adminwallpaper/Screens/uploadbanner/selectbannerphotos.dart';
import 'package:adminwallpaper/Screens/upload_modify_delete_catagories/CatagoryMenu.dart';
import 'package:adminwallpaper/Screens/upload_modify_delete_products/ProductMainMenu.dart';
import 'package:adminwallpaper/Screens/upload_modify_delete_products/ProductScreenViews/SelectCatagoriesScreen.dart';
import 'package:flutter/material.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  _MainMenuScreenState createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  List<String> dashboard_heading = [
    "manage stocks",
    "Manage catagories",
    "upload banner",
    "Manage orderList",
    "manage customers",
    "manage riders",
    // "Manage store locations",
    // "Customize orders"
  ];

  List<String> dashboard_descriptions = [
    "upload products,update inventory",
    "upload, delete, modify catagories",
    "upload 3 pictures of banners",
    "view sold, pending, canceled orders",
    "upgrade,modify or delete customer",
    "upgrade,modify rider",
    // "view & upload new store on maps",
    // "View Customizable orders"
  ];

  List navigators = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("DashBoard"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: 6,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (index == 0) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductMainMenu()));
                } else if (index == 1) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CatagoryMenu()));
                } else if (index == 2) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectBannerPhoto()));
                } else if (index == 4) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AllCustomer()));
                } else if (index == 3) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => OrderListMenu()));
                } else if (index == 5) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AllRiders()));
                }
              },
              child: Column(
                children: [
                  Divider(
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 40,
                        width: 39,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black)),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dashboard_heading[index],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            dashboard_descriptions[index],
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:shopnest/Screens/AccountDetails.dart';
import 'package:shopnest/Screens/CatagoryScreen.dart';
import 'package:shopnest/Screens/FavouriteScreen.dart';
import 'package:shopnest/Screens/LandingScreen.dart';
import 'package:shopnest/Screens/Location.dart';
import 'package:shopnest/Screens/MyBagScreen.dart';
import 'package:shopnest/Screens/TemperoryScreen.dart';
import 'package:flutter/material.dart';

class MainDisplayScreen extends StatefulWidget {
  const MainDisplayScreen({Key? key}) : super(key: key);

  @override
  _MainMenuScreenState createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainDisplayScreen> {
  int _selectedIndex = 2;
  List<Widget> fiveConatiners = [
    FirstCatagoryScreen(),
    FavouriteItems(),
    LandingScreen(),
    //   LocationScreen(),
    AccountDetails()
  ];
  List<String> titletext = [
    "Catagories",
    "Favorite",
    "Home Store",
    //   "Location",
    "Accounts"
  ];
  late TabController _tabController;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            titleSpacing: 72,
            title: Text(
              titletext[_selectedIndex],
              style: TextStyle(color: Colors.grey[700]),
            ),
            centerTitle: true,
            // leading: Padding(
            //   padding: EdgeInsets.all(5),
            //   child: Image.asset("assets/download.png"),
            // ),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyBagScreen()));
                },
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              )
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.grey[700],
            onTap: (value) {
              setState(() {
                print(value);
                _selectedIndex = value;
              });
            },
            type: BottomNavigationBarType.fixed,
            items: [
              new BottomNavigationBarItem(
                icon: new Icon(Icons.menu),
                label: "Catagory",
              ),
              new BottomNavigationBarItem(
                icon: new Icon(Icons.favorite),
                label: "Favorite",
              ),
              new BottomNavigationBarItem(
                icon: new Icon(Icons.home),
                label: "Home",
              ),
              // new BottomNavigationBarItem(
              //   icon: new Icon(Icons.location_on_sharp),
              //   label: "Location",
              // ),
              new BottomNavigationBarItem(
                icon: new Icon(Icons.account_circle_outlined),
                label: "Account",
              )
            ],
          ),
          body: fiveConatiners[_selectedIndex]),
    );
  }
}

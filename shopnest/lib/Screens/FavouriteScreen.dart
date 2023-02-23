import 'package:shopnest/Models/StreamBuilders.dart';
import 'package:shopnest/Models/StreamFavourite.dart';
import 'package:shopnest/Screens/ProductViewScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavouriteItems extends StatefulWidget {
  const FavouriteItems({Key? key}) : super(key: key);

  @override
  _FavouriteItemsState createState() => _FavouriteItemsState();
}

class _FavouriteItemsState extends State<FavouriteItems> {
  final mauth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    if (mauth.currentUser != null) {
      print(mauth.currentUser!.uid.toString());
    } else {
      print("user is null");
    }
  }

  Widget showitems() {
    return Container(
        child: StreamFavourite(
      scrollDirection: Axis.vertical,
      gridlength: 4,
      size: .6,
      scrollphysics: NeverScrollableScrollPhysics(),
      crosscountaxis: 2,
    ));
  }

  Widget showsimilar() {
    return StreamGridbuilder(
      catagaoryname: "temp",
      subcatagoryname: "temp",
      crosscountaxis: 2,
      scrollDirection: Axis.vertical,
      gridlength: 4,
      size: .6,
      scrollphysics: NeverScrollableScrollPhysics(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Favourite Items",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.grey)),
                  child: Text(
                    "View all",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          mauth.currentUser != null
              ? showitems()
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black)),
                  child: Center(
                    child: Text("sign in to unlock favourite"),
                  ),
                ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

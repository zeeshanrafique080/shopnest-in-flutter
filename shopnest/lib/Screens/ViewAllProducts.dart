import 'package:shopnest/Models/StreamBuilders.dart';
import 'package:shopnest/Screens/ProductViewScreen.dart';
import 'package:flutter/material.dart';

class ViewAllProducts extends StatefulWidget {
  final cataname;
  final subcataname;
  ViewAllProducts({Key? key, required this.cataname, required this.subcataname})
      : super(key: key);

  @override
  _ViewAllProductsState createState() => _ViewAllProductsState();
}

class _ViewAllProductsState extends State<ViewAllProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: StreamGridbuilder(
            catagaoryname: widget.cataname,
            subcatagoryname: widget.subcataname,
            crosscountaxis: 2,
            scrollDirection: Axis.vertical,
            gridlength: 20,
            size: .58,
            scrollphysics: AlwaysScrollableScrollPhysics(),
          )),
    );
  }
}

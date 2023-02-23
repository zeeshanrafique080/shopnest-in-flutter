import 'package:flutter/material.dart';
class TemperoryScreen extends StatefulWidget {
  const TemperoryScreen({ Key? key }) : super(key: key);

  @override
  _TemperoryScreenState createState() => _TemperoryScreenState();
}

class _TemperoryScreenState extends State<TemperoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Text("Confusing Part"),
          
          Text("there is a My Bag page on the top right"),
          
          Text("Corner of the Screen..."),
          
          Text("there is no need to create My Bag page over here and the screen below will be suitable here"),
          Container(
            height: 300,
            child: Image.asset("assets/tempscreen.jpg")),

             Text("What do u say ...?"),


        ],
      ),
      
    );
  }
}
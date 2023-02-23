import 'package:flutter/material.dart';

class Managestocks extends StatefulWidget {
  const Managestocks({Key? key}) : super(key: key);

  @override
  _ManagestocksState createState() => _ManagestocksState();
}

class _ManagestocksState extends State<Managestocks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(20),
      child: ListView(children: [
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text("Total products :"),
                  SizedBox(width: 20),
                  Text("2000"),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Flexible(
              flex: 0,
              fit: FlexFit.loose,
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, //background color of button

                    elevation: 3, //elevation of button
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9)),
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.add),
                  label: Text("add product")),
            ),
            SizedBox(
              width: 20,
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.loose,
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, //background color of button

                    elevation: 3, //elevation of button
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9)),
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.remove),
                  label: Text("delete product")),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Colors.yellow, //background color of button

                  elevation: 3, //elevation of button
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9)),
                ),
                onPressed: () {},
                icon: Icon(
                  Icons.change_circle,
                  color: Colors.black,
                ),
                label: Text(
                  "modify product",
                  style: TextStyle(color: Colors.black),
                )),
          ],
        )
      ]),
    ));
  }
}

import 'package:flutter/material.dart';

class HelpCenter extends StatefulWidget {
  const HelpCenter({Key? key}) : super(key: key);

  @override
  _HelpCenterState createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
  Widget infobox(heading, data, Icon incon) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          border: Border.all(color: Colors.black)),
      child: Column(
        children: [
          incon,
          Divider(
            color: Colors.black,
          ),
          ExpansionTile(
            title: Text(heading),
            children: [Text(data)],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20),
            child: ListView(
              children: [
                Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back)),
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      "Help Center",
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                infobox(
                  "Popular Questions",
                  " questions data...................",
                  Icon(Icons.question_answer_outlined),
                ),
                SizedBox(
                  height: 20,
                ),
                infobox(
                  "Order",
                  " order details",
                  Icon(Icons.shop),
                ),
                SizedBox(
                  height: 20,
                ),
                infobox(
                  "Shipping and delivery",
                  " .......................",
                  Icon(Icons.delivery_dining),
                ),
                SizedBox(
                  height: 20,
                ),
                infobox(
                  "Payment methods",
                  ".....................",
                  Icon(Icons.payment_rounded),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            )));
  }
}

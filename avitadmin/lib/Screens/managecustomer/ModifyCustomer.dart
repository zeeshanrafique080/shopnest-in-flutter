import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ModifyCustomer extends StatefulWidget {
  final String customerdocid;
  const ModifyCustomer({Key? key, required this.customerdocid})
      : super(key: key);

  @override
  _ModifyCustomerState createState() => _ModifyCustomerState();
}

class _ModifyCustomerState extends State<ModifyCustomer> {
  final name = TextEditingController();
  final phone = TextEditingController();
  final country = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            SizedBox(
              height: 60,
            ),
            ExpansionTile(children: [
              TextField(
                decoration: InputDecoration(hintText: "enter name here"),
                controller: name,
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection("Consumers")
                        .doc(widget.customerdocid)
                        .update({"consumer name": name.text.trim().toString()});
                  },
                  child: Text("modfiy now"))
            ], title: Text("modify customer name")),
            SizedBox(
              height: 20,
            ),
            ExpansionTile(children: [
              TextField(
                decoration: InputDecoration(hintText: "enter phone number"),
                controller: phone,
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection("Consumers")
                        .doc(widget.customerdocid)
                        .update(
                            {"consumer phone": phone.text.trim().toString()});
                  },
                  child: Text("modfiy now"))
            ], title: Text("modify phone number")),
            SizedBox(
              height: 20,
            ),
            ExpansionTile(children: [
              TextField(
                decoration: InputDecoration(hintText: "enter country"),
                controller: country,
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection("Consumers")
                        .doc(widget.customerdocid)
                        .update({
                      "consumer country": country.text.trim().toString()
                    });
                  },
                  child: Text("modfiy now"))
            ], title: Text("modify customer country")),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

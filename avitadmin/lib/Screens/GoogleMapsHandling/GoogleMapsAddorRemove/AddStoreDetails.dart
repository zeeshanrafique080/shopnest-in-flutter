import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddStoreDetails extends StatefulWidget {
  final String docid;
  const AddStoreDetails({Key? key, required this.docid}) : super(key: key);

  @override
  _AddStoreDetailsState createState() => _AddStoreDetailsState();
}

class _AddStoreDetailsState extends State<AddStoreDetails> {
  final storename = TextEditingController();
  final storelocation = TextEditingController();
  final storenumber = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: storename,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "must enter something";
                  }
                },
                decoration: InputDecoration(labelText: "enter store name"),
              ),
              TextFormField(
                controller: storelocation,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "must enter something";
                  }
                },
                decoration: InputDecoration(labelText: "enter store location"),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: storenumber,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "must enter something";
                  }
                },
                decoration: InputDecoration(labelText: "store contact details"),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await FirebaseFirestore.instance
                          .collection("Store Locations")
                          .doc(widget.docid)
                          .update({
                        "Store name": storename.text.trim().toString(),
                        "Store location": storelocation.text.trim().toString(),
                        "Store number": storenumber.text.trim().toString(),
                        "show location": "true",
                      });
                    }
                  },
                  child: Text("submit"))
            ],
          ),
        ),
      ),
    );
  }
}

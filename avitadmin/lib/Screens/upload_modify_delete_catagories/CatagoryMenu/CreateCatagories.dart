import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

class CreateCatagories extends StatefulWidget {
  const CreateCatagories({Key? key}) : super(key: key);

  @override
  _CreateCatagoriesState createState() => _CreateCatagoriesState();
}

class _CreateCatagoriesState extends State<CreateCatagories> {
  TextEditingController catagoryname = TextEditingController();
  TextEditingController subcatagoryname = TextEditingController();
  TextEditingController updated_subcatagory_name = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String SelectedCatagory = "";
  Widget textfields(TextEditingController controller, String hint) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: hint),
      validator: (value) {
        if (value!.isEmpty) {
          return "must enter data";
        }
        return null;
      },
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Select catagory',
            style: TextStyle(
                fontSize: 25,
                fontFamily: 'LobsterTwo Bold',
                color: Colors.amber),
          ),
          elevation: 5,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                streamSubCatagories(),
                textfields(updated_subcatagory_name, "sub cata- name")
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Got it!',
                  style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'LobsterTwo Bold',
                      color: Colors.black)),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget streamSubCatagories() {
    return StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection("AvitCatagories").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ExpansionTile(
              childrenPadding: EdgeInsets.symmetric(horizontal: 30),
              trailing: Icon(Icons.arrow_drop_down),
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot curDoc = snapshot.data!.docs[index];
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            SelectedCatagory = curDoc.get("CatagoryName");
                          });
                        },
                        child: Center(
                            child: Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  curDoc.get("CatagoryName"),
                                  style: TextStyle(fontSize: 22),
                                ))));
                  },
                )
              ],
              title: Text(
                SelectedCatagory.isEmpty ? "Select catagory" : SelectedCatagory,
                style: TextStyle(fontSize: 15),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(25),
            child: Form(
              key: _formKey,
              child: ListView(children: [
                Container(
                  height: 80,
                  width: 80,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey)),
                  child: Image.asset("assets/testingAvit.jpg"),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "add multiple catagories with atleast \n one sub catagory inside it..",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
                SizedBox(
                  height: 15,
                ),
                textfields(catagoryname, "catagory name"),
                SizedBox(
                  height: 15,
                ),
                textfields(subcatagoryname, "sub-catagory name"),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    onPressed: () {
                      ProgressDialog dialog = ProgressDialog(context,
                          title: Text("loading"),
                          message: Text("Wait for a little while"));
                      dialog.show();
                      if (_formKey.currentState!.validate()) {
                        FirebaseFirestore.instance
                            .collection("AvitCatagories")
                            .add({
                          "CatagoryName": catagoryname.text.toString().trim(),
                          "Subcatagories": FieldValue.arrayUnion(
                              [subcatagoryname.text.toString().trim()])
                        });
                      }
                      dialog.dismiss();
                    },
                    child: Text("create catagory")),
                SizedBox(
                  height: 15,
                ),
              ]),
            )));
  }
}

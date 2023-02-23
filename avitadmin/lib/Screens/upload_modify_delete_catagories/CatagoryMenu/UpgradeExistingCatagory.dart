import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

class UpgradeExistingCatagory extends StatefulWidget {
  const UpgradeExistingCatagory({Key? key}) : super(key: key);

  @override
  _UpgradeExistingCatagoryState createState() =>
      _UpgradeExistingCatagoryState();
}

class _UpgradeExistingCatagoryState extends State<UpgradeExistingCatagory> {
  String SelectedCatagory = "";
  TextEditingController updated_subcatagory_name = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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

  Widget streamCatagories() {
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
          child: ListView(
            children: [
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
              streamCatagories(),
              SizedBox(
                height: 15,
              ),
              textfields(updated_subcatagory_name, "enter sub-cata name"),
              ElevatedButton(
                  onPressed: () {
                    ProgressDialog dialog = ProgressDialog(context,
                        title: Text("loading"),
                        message: Text("Wait for a little while"));
                    dialog.show();
                    if (_formKey.currentState!.validate() &&
                        SelectedCatagory.isNotEmpty) {
                      FirebaseFirestore.instance
                          .collection("AvitCatagories")
                          .where("CatagoryName",
                              isEqualTo: SelectedCatagory.toString().trim())
                          .get()
                          .then((value) {
                        value.docs.forEach((element) {
                          FirebaseFirestore.instance
                              .collection("AvitCatagories")
                              .doc(element.id)
                              .update({
                            "Subcatagories": FieldValue.arrayUnion([
                              updated_subcatagory_name.text.toString().trim()
                            ])
                          });
                        });
                      });
                    }
                    dialog.dismiss();
                  },
                  child: Text("create catagory")),
            ],
          ),
        ),
      ),
    );
  }
}

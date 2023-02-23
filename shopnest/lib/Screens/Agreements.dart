import 'package:flutter/material.dart';

class Agreements extends StatefulWidget {
  const Agreements({Key? key}) : super(key: key);

  @override
  _AgreementsState createState() => _AgreementsState();
}

class _AgreementsState extends State<Agreements> {
  Widget agreementlist(heading) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(heading), Icon(Icons.arrow_forward)],
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
                  "Agreements",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            agreementlist("terms of use"),
            SizedBox(
              height: 20,
            ),
            agreementlist("GDPR privacy policy"),
            SizedBox(
              height: 20,
            ),
            agreementlist("Modern slavery statement"),
            SizedBox(
              height: 20,
            ),
            agreementlist("Privacy Policy"),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

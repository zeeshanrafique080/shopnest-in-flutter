
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Customizrshorts extends StatefulWidget {

  const Customizrshorts({Key? key,}) : super(key: key);

  @override
  State<Customizrshorts> createState() => _CustomizrshortsState();
}

class _CustomizrshortsState extends State<Customizrshorts> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Customize Orders',
            style: TextStyle(
                color: Colors.black, fontFamily: "Trajan Pro", fontSize: 25)),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.all(25),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("customize orders")
              .where(
                "status",
                isEqualTo: "pending",
              )
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.amber,
                ),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot current_doc = snapshot.data!.docs[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  height: 440,
                  width: size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey,
                      border: Border.all(
                        color: Colors.grey.withOpacity(.6),
                      )),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 8, right: 8, bottom: 5),
                        child: Column(
                         
                          children: [
                            Container(
                              height: 30,
                              width: 25,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white)
                              ),
                              child: Center(
                                child: Text(
                                  "${index + 1}",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.white,
                            ),
                            
                          ],
                        ),
                      ),
                      Hero(
                        tag: index,
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          height: 140,
                          width: size.width,
                          imageUrl: current_doc.get("image link"),
                          placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(
                            color: Colors.green,
                          )),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 8, right: 8, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "Customer Name : ${current_doc.get("customer name")}",
                                style: TextStyle(
                                    color: Colors.white,
                                   fontFamily: "new",
                                    fontSize: 13)),
                            Column(
                              children: [
                                Text(
                                    "Date (${current_doc.get("uploading date")})",
                                    style: TextStyle(
                                        color: Colors.white,
                                       fontFamily: "new",
                                        fontSize: 13)),
                                         Text(
                                    "Time (${current_doc.get("uploading time")})",
                                    style: TextStyle(
                                        color: Colors.white,
                                       fontFamily: "new",
                                        fontSize: 13)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Colors.white),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8,
                          right: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Chest Size : ${current_doc.get("chest size")}",
                                style: TextStyle(
                                    color: Colors.white,
                                   fontFamily: "new",
                                    fontSize: 13)),
                                     Text(
                                "Shoulder size : ${current_doc.get("Shoulders size")}",
                                style: TextStyle(
                                    color: Colors.white,
                                   fontFamily: "new",
                                    fontSize: 13)),
                                     Text(
                                "Collar Size : ${current_doc.get("collar size")}",
                                style: TextStyle(
                                    color: Colors.white,
                                   fontFamily: "new",
                                    fontSize: 13)),
                                      
                                    Text(
                                "Description: ${current_doc.get("item description")}",
                                style: TextStyle(
                                    color: Colors.white,
                                   fontFamily: "new",
                                    fontSize: 13)),
                                     Text(
                                "Contact # : ${current_doc.get("customer contact number")}",
                                style: TextStyle(
                                    color: Colors.white,
                                   fontFamily: "new",
                                    fontSize: 15)),
                            
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: ElevatedButton(onPressed: (){
                          current_doc.reference.update({
                            "status": "delivered"
                          });
                        }, child: Text("delivered")),
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

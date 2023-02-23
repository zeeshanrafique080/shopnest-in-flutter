import 'package:flutter/material.dart';

class DeliveryReturn extends StatefulWidget {
  const DeliveryReturn({Key? key}) : super(key: key);

  @override
  _DeliveryReturnState createState() => _DeliveryReturnState();
}

class _DeliveryReturnState extends State<DeliveryReturn> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "United States of America",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          "Brand delivery & return status will be written here",
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class InventoryNumber extends StatefulWidget {
  const InventoryNumber({Key? key}) : super(key: key);

  @override
  _InventoryNumberState createState() => _InventoryNumberState();
}

class _InventoryNumberState extends State<InventoryNumber> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Chip(label: Text('101340003428')),
          SizedBox(
            width: 8,
          ),
          Chip(label: Text('101340003428')),
          SizedBox(
            width: 8,
          ),
          Chip(label: Text('101340003428')),
          SizedBox(
            width: 8,
          ),
          Chip(label: Text('101340003428')),
          SizedBox(
            width: 8,
          ),
          Chip(label: Text('101340003428')),
          SizedBox(
            width: 8,
          ),
          Chip(label: Text('101340003428'))
        ],
      ),
    );
  }
}

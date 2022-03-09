import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

List<String> _tags = <String>[
  'Tag 1',
  'Tag 2',
  'Tag 3',
  'Tag 4',
  'Tag 5',
  'Tag 6',
  'Tag 7',
  'Tag 8',
  'Tag 9',
];

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Orders Screen')),
    );
  }
}

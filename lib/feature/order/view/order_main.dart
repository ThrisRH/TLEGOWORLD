import 'package:flutter/material.dart';

void main() {
  runApp(const OrderMain());
}

class OrderMain extends StatelessWidget {
  const OrderMain({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            'Order Page',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

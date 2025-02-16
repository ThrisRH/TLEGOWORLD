import 'package:flutter/material.dart';

void main() {
  runApp(const NofiMain());
}

class NofiMain extends StatelessWidget {
  const NofiMain({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            'Nofi Page',
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

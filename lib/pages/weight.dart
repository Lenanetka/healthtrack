import 'package:flutter/material.dart';

class Weight extends StatelessWidget {
  const Weight({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weight'),
      ),
      body: const Center(
        child: Text('Weight adding page content goes here.'),
      ),
    );
  }
}

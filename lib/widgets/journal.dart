import 'package:flutter/material.dart';
import '../models/page_with_title.dart';

class Journal extends StatefulWidget implements PageWithTitle {
  const Journal({super.key});

  @override
  State<Journal> createState() => _JournalState();
  @override
  String get title => 'Journal';
}

class _JournalState extends State<Journal> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../widgets/navigation.dart';
import 'package:provider/provider.dart';
import 'models/journal_database.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => JournalDatabase()),
      ],
      child: MaterialApp(
      title: 'Health Track',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const Navigation(),
    ),
    );
  }
}

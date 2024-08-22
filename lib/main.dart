import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/navigation.dart';
import 'models/journal_database.dart';
import 'theme/theme.dart';

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
        theme: lightThemeData(context),
        darkTheme: darkThemeData(context),
        debugShowCheckedModeBanner: false,
        home: const Navigation(),
      ),
    );
  }
}

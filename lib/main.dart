import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/navigation.dart';
import 'models/journal_database.dart';
import 'theme/theme.dart';
import 'theme/theme_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider()..initialaze(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => JournalDatabase()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Health Track',
            theme: lightMode,
            darkTheme: darkMode,
            themeMode: themeProvider.themeMode,
            debugShowCheckedModeBanner: false,
            home: const Navigation(),
          );
        },
      ),
    );
  }
}

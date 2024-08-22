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
          colorScheme: ColorScheme(
            primary: Colors.grey[800]!, // User info in menu
            secondary: Colors.grey[700]!,
            surface: Colors
                .grey[900]!, // Menu background, Save button color in Profile
            error: Colors.red,
            //Text colors:
            onPrimary: Colors.white,
            onSecondary: Colors.white,
            onSurface:
                const Color.fromARGB(255, 220, 220, 220), //Text color in body
            onError: Colors.white,
            brightness: Brightness.dark,
          ),
          scaffoldBackgroundColor: Colors.grey[850], // Background of body
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey[900], //App bar and filters on the top
            foregroundColor: Colors.white, //Text and icons color in App bar
          ),
          useMaterial3: true,
        ),
        home: const Navigation(),
      ),
    );
  }
}
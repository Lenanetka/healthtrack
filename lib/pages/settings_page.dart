import 'package:flutter/material.dart';
import '../models/page_with_title.dart';
import '../widgets/theme_switcher.dart';

class SettingsPage extends StatefulWidget implements PageWithTitle {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
  @override
  Icon get icon => const Icon(Icons.settings);
  @override
  String get title => 'Settings';
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ThemeSwitcher(),
            //Add other settings here with const SizedBox(height: 20) in between
          ],
        ),
      ),
    );
  }
}

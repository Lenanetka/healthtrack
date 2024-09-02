import 'package:flutter/material.dart';
import '../models/page_with_title.dart';
import '../pages/journal_page.dart';
import '../pages/profile_page.dart';
import '../pages/settings_page.dart';
import '../pages/weight_statistics_page.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  NavigationState createState() => NavigationState();
}

class NavigationState extends State<Navigation> {
  Widget _bodyContent = const JournalPage();
  Widget _title = const Text('Journal');

  final List<PageWithTitle> _pages = [
    const JournalPage(),
    const ProfilePage(),
    const SettingsPage(),
    const WeightStatisticsPage(),
  ];

  void _open(pageKey) {
    setState(() {
      _title = Text(_pages[pageKey].title);
      _bodyContent = _pages[pageKey];
    });
    Navigator.of(context).pop();
  }

  Widget drawerHeader() {
    return const UserAccountsDrawerHeader(
      accountName: Text('User Name'),
      accountEmail: Text('user.name@email.com'),
      currentAccountPicture: Icon(
        Icons.account_circle,
        size: 48.0,
        color: Colors.white,
      ),
    );
  }

  Widget drawerItems(BuildContext context) {
    return ListView(
      children: <Widget>[
        drawerHeader(),
        ..._pages.asMap().entries.map((item) {
          int pageKey = item.key;
          PageWithTitle page = item.value;
          return ListTile(
            leading: page.icon,
            title: Text(page.title),
            onTap: () => _open(pageKey),
          );
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title,
      ),
      body: _bodyContent,
      drawer: Drawer(
        child: drawerItems(context),
      ),
    );
  }
}

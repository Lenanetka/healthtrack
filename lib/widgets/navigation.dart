import 'package:flutter/material.dart';
import '../models/page_with_title.dart';
import 'journal.dart';
import 'profile.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  NavigationState createState() => NavigationState();
}

class NavigationState extends State<Navigation> {
  Widget _bodyContent = const Journal();
  Widget _title = const Text('Journal');

  final List<PageWithTitle> _pages = [
    const Journal(),
    const Profile(),
  ];

  void _open(page) {
    setState(() {
      _title = Text(_pages[page].title);
      _bodyContent = _pages[page];
    });
    Navigator.of(context).pop(); // Close the menu
  }

  @override
  Widget build(BuildContext context) {
    const drawerHeader = UserAccountsDrawerHeader(
      accountName: Text('User Name'),
      accountEmail: Text('user.name@email.com'),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.white,
        child: FlutterLogo(size: 42.0), //Text('A')
      ),
    );
    final drawerItems = ListView(
      children: <Widget>[
        drawerHeader,
        ListTile(
          title: Text(_pages[0].title),
          onTap: () => _open(0),
        ),
        ListTile(
          title: Text(_pages[1].title),
          onTap: () =>_open(1),
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: _title,
      ),
      body: _bodyContent,
      drawer: Drawer(
        child: drawerItems,
      ),
    );
  }
}

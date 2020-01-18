import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tree_secure/screens/adopted_trees/adopted_trees.dart';
import 'package:tree_secure/screens/discover_trees/discover_trees.dart';
import 'package:tree_secure/screens/visited_trees/visited_trees.dart';
import 'package:tree_secure/services/auth_service.dart';
import 'package:tree_secure/models/user.dart';
import 'package:tree_secure/models/auth_user.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _auth = AuthService.instance;

  List<Widget> pages = [AdoptedTrees(), DiscoverTrees(), VisitedTrees()];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    final AuthUser authUser = Provider.of<AuthUser>(context);

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0.0),
          children: <Widget>[
            UserAccountsDrawerHeader(
              margin: const EdgeInsets.all(0.0),
              currentAccountPicture: CircleAvatar(
                radius: 30.0,
                backgroundImage:
                    NetworkImage('https://via.placeholder.com/150'),
                backgroundColor: Colors.transparent,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              accountName: Text(user.name),
              accountEmail: Text(authUser.user.email),
            ),
            ListTile(
              onTap: () {
                _onChangePage(0);
              },
              selected: 0 == index,
              title: Text('Adopted Trees'),
            ),
            ListTile(
              onTap: () {
                _onChangePage(1);
              },
              selected: 1 == index,
              title: Text('Discover Trees'),
            ),
            ListTile(
              onTap: () {
                _onChangePage(2);
              },
              selected: 2 == index,
              title: Text('Visited Trees'),
            ),
            ListTile(
              onTap: () {
                this._auth.signOut();
                Navigator.of(context).pop();
              },
              title: Text('Logout'),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('# Team Trees'),
        actions: <Widget>[],
      ),
      body: pages[index],
    );
  }

  _onChangePage(int selectedIndex) {
    setState(() => index = selectedIndex);
    Navigator.of(context).pop(); // close the drawer
  }
}

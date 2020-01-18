import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tree_secure/services/auth_service.dart';
import 'package:tree_secure/models/user.dart';
import 'package:tree_secure/screens/splash/splash_screen.dart';

class HomeScreen extends StatelessWidget {
  final AuthService _auth = AuthService.instance;

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);

    return user == null
        ? SplashScreen()
        : Scaffold(
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
                    accountName: Text("user account name"),
                    accountEmail: Text("user account email"),
                  ),
                  ListTile(
                    onTap: () {},
                    title: Text('Adopted Trees'),
                  ),
                  ListTile(
                    onTap: () {},
                    title: Text('Visited Trees'),
                  ),
                  ListTile(
                    onTap: () {
                      this._auth.signOut();
                    },
                    title: Text('Logout'),
                  )
                ],
              ),
            ),
            appBar: AppBar(
              title: Text('Tree Secure'),
              actions: <Widget>[],
            ),
            body: Text('LOGGED IN'),
          );
  }
}

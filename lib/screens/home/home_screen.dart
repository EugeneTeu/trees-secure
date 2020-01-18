import 'package:flutter/material.dart';

import 'package:tree_secure/services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  final AuthService _auth = AuthService.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tree Secure'),
        actions: <Widget>[
          RaisedButton(
            child: Text('Logout'),
            onPressed: () {
              this._auth.signOut();
            },
          )
        ],
      ),
      body: Text('LOGGED IN'),
    );
  }
}
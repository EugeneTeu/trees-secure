import 'package:flutter/material.dart';

import 'package:tree_secure/screens/auth/sign_in.dart';
import 'package:tree_secure/screens/auth/register.dart';
import 'package:tree_secure/screens/tree_secure_logo.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => this.showSignIn = !this.showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    Widget view = this.showSignIn ? SignIn(toggleView) : Register(toggleView);

    return Scaffold(
      /*
      appBar: AppBar(
        title: Text('Tree Secure'),
        centerTitle: true,
      ),*/
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: FractionallySizedBox(
            widthFactor: 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TreeSecureLogo(),
                view,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

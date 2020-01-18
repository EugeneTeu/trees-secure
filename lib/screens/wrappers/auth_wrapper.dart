import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tree_secure/screens/auth/auth_screen.dart';
import 'package:tree_secure/screens/home/home_screen.dart';
import 'package:tree_secure/models/auth_user.dart';
import 'package:tree_secure/screens/splash/splash_screen.dart';
import 'package:tree_secure/services/firestore_service.dart';
import 'package:tree_secure/models/user.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthUser authUser = Provider.of<AuthUser>(context);

    if (authUser == null) {
      // on first startup; show splashscreen to get UserModel
      return SplashScreen();
    } else if (!authUser.hasData) {
      // UserModel no data; user is not authenticated yet
      return AuthScreen();
    } else {
      // UserModel is ok; user is authenticated successfully
      FirestoreService.initInstance(uid: authUser.uid);
      return StreamProvider<User>.value(
        value: FirestoreService.instance.currUser,
        child: HomeScreen(),
      );
    }
  }
}

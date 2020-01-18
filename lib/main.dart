import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:tree_secure/screens/wrappers/auth_wrapper.dart';
import 'package:tree_secure/services/auth_service.dart';
import 'package:tree_secure/models/auth_user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AuthUser>.value(
      value: AuthService.instance.currUserModel,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthWrapper(),
      ),
    );
  }
}

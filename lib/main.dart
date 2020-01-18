import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:tree_secure/Themes/theme.dart';
import 'package:tree_secure/screens/wrappers/auth_wrapper.dart';
import 'package:tree_secure/services/auth_service.dart';
import 'package:tree_secure/models/auth_user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<AuthUser>(
            create: (context) => AuthService.instance.currUserModel)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: buildDarkTheme(),
        home: AuthWrapper(),
      ),
    );
  }
}

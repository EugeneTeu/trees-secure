import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:tree_secure/models/static_data.dart';

import 'package:tree_secure/screens/wrappers/auth_wrapper.dart';
import 'package:tree_secure/services/auth_service.dart';
import 'package:tree_secure/models/auth_user.dart';
import 'package:tree_secure/themes/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StaticData>(
          create: (_) => StaticData()..loadTreeFromJson(),
        ),
        StreamProvider<AuthUser>.value(
          value: AuthService.instance.currUserModel,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: buildLightTheme(),
        home: AuthWrapper(),
      ),
    );
  }
}

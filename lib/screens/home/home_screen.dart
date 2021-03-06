import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:tree_secure/models/static_data.dart';

import 'package:tree_secure/screens/adopted_trees/adopted_trees.dart';
import 'package:tree_secure/screens/discover_trees/discover_trees_map.dart';
import 'package:tree_secure/screens/settings_page/settings_page.dart';
import 'package:tree_secure/screens/splash/splash_screen.dart';
import 'package:tree_secure/screens/visited_trees/visited_trees.dart';
import 'package:tree_secure/services/auth_service.dart';
import 'package:tree_secure/models/user.dart';
import 'package:tree_secure/models/auth_user.dart';
import 'package:tree_secure/themes/theme.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _auth = AuthService.instance;
  static final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<Widget> pages = [
    DiscoverTreesMap(_scaffoldKey),
    AdoptedTrees(),
    VisitedTrees(),
    SettingsPage()
  ];
  List<Widget> pageTitle = [
    Text('Discover Trees'),
    Text('Adopted Trees'),
    Text('Visited Trees'),
    Text('Settings'),
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    final AuthUser authUser = Provider.of<AuthUser>(context);

    if (user == null) {
      return SplashScreen(
        isDataDocEmpty: false,
      );
    } else if (user.id == null) {
      return SplashScreen(
        isDataDocEmpty: true,
      );
    }

    return (MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: user.isDarkTheme ? buildDarkTheme() : buildLightTheme(),
      home: Scaffold(
        resizeToAvoidBottomPadding : false,
        key: _scaffoldKey,
        drawer: Drawer(
          child: ListView(
            padding: const EdgeInsets.all(0.0),
            children: <Widget>[
              UserAccountsDrawerHeader(
                margin: const EdgeInsets.all(0.0),
                currentAccountPicture: CircleAvatar(
                  radius: 30.0,
                  backgroundImage:
                      NetworkImage('https://i.etsystatic.com/13693104/r/il/6f7817/1499379340/il_1588xN.1499379340_9dk7.jpg'),
                  backgroundColor: Colors.transparent,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                accountName: Text(user.name),
                accountEmail: Text(authUser.user.email),
                otherAccountsPictures: <Widget>[
                  IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      _onChangePage(3);
                    },
                  ),
                ],
              ),
              ListTile(
                leading: Icon(LineIcons.fire),
                onTap: () {
                  _onChangePage(0);
                },
                selected: 0 == index,
                title: Text(
                  'Discover Trees',
                  style: TextStyle(fontSize: 17),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              ),
              ListTile(
                leading: Icon(LineIcons.dollar),
                onTap: () {
                  _onChangePage(1);
                },
                selected: 1 == index,
                title: Text(
                  'Adopted Trees',
                  style: TextStyle(fontSize: 17),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              ),
              ListTile(
                leading: Icon(LineIcons.leaf),
                onTap: () {
                  _onChangePage(2);
                },
                selected: 2 == index,
                title: Text(
                  'Visited Trees',
                  style: TextStyle(fontSize: 17),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: pageTitle[index],
          actions: <Widget>[],
        ),
        body: pages[index],
      ),
    ));
  }

  _onChangePage(int selectedIndex) {
    setState(() => index = selectedIndex);
    _scaffoldKey.currentState.openEndDrawer();
    // Navigator.of(context).pop(); // close the drawer
  }
}

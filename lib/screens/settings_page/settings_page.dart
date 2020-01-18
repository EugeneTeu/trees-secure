import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tree_secure/models/user.dart';
import 'package:tree_secure/services/auth_service.dart';
import 'package:tree_secure/services/firestore_service.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with AutomaticKeepAliveClientMixin {
  AuthService _auth = AuthService.instance;
  FirestoreService _fs = FirestoreService.instance;

  void _displayNameDialog(String initialName) {
    String enteredName = initialName;

    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: TextFormField(
            initialValue: initialName,
            decoration: InputDecoration(
              labelText: 'Display Name',
            ),
            onChanged: (String val) => enteredName = val,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('CONFIRM'),
              onPressed: () {
                _fs.setUserDisplayName(enteredName);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final User user = Provider.of<User>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListView(
          shrinkWrap: true,
          children: ListTile.divideTiles(
            context: context,
            tiles: <Widget>[
              ListTile(
                title: Text(
                  'Display Name',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.body1.color,
                  ),
                ),
                trailing: RaisedButton(
                  child: Text(user.name),
                  elevation: 0,
                  onPressed: () => _displayNameDialog(user.name),
                ),
              ),
              ListTile(
                title: FlatButton(
                  child: Text('SIGN OUT'),
                  onPressed: () => _auth.signOut(),
                ),
              )
            ],
          ).toList(),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

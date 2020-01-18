import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthUser with ChangeNotifier {
  FirebaseUser _user;
  String _uid;
  bool _hasData;

  AuthUser({FirebaseUser user, String uid, @required bool hasData}) {
    this._user = user;
    this._uid = uid;
    this._hasData = hasData;
  }

  FirebaseUser get user => _user;
  String get uid => _uid;
  bool get hasData => _hasData;
}

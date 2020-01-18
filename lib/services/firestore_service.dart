import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:tree_secure/models/user.dart';

class FirestoreService {
  static FirestoreService _instance;

  final String uid;
  final DocumentReference userDocument;

  static void initInstance({@required String uid}) {
    // ensure method only called once per user
    if (_instance == null || _instance.uid != uid) {
      _instance = FirestoreService._init(uid: uid);
    }
  }

  static FirestoreService get instance {
    assert(_instance != null);
    return _instance;
  }

  FirestoreService._init({@required String uid})
      : this.userDocument =
            Firestore.instance.collection('users').document(uid),
        this.uid = uid;

  User _createUser(DocumentSnapshot doc) {
    if (doc.data == null) {
      return User();
    }

    User userDoc = User.fromJson(doc.data);
    userDoc.id = doc.documentID;
    return userDoc;
  }

  Stream<User> get currUser {
    return this.userDocument.snapshots().map(_createUser);
  }

  void createUserDoc() async {
    return this.userDocument.setData({
      'adopted_trees': [],
      'created_at': DateTime.now(),
      'is_dark_theme': false,
      'modified_at': DateTime.now(),
      'name': '',
      'visited_trees': [],
    });
  }

  void setUserDisplayName(String name) {
    this.userDocument.updateData({
      'name': name,
    });
  }

  void setDarkTheme(bool newBool) {
    this.userDocument.updateData({
      'is_dark_theme': newBool,
    });
  }

  String generateSecret() {
    
  }
}

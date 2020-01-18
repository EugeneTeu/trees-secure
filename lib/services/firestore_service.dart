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
    return doc.data == null ? null : User.fromJson(doc.data);
  }

  Stream<User> get currUser {
    return this.userDocument.snapshots().map(_createUser);
  }
}

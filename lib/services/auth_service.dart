import 'package:firebase_auth/firebase_auth.dart';

import 'package:tree_secure/models/auth_user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // private constructor to make this the only available constructor
  AuthService._init();

  static final AuthService instance = AuthService._init();

  // create custom User obj
  AuthUser _createUserModel(FirebaseUser user) {
    return user == null
        ? AuthUser(hasData: false)
        : AuthUser(user: user, uid: user.uid, hasData: true);
  }

  // provider in main.dart will reference this getter
  // listens to the auth state stream and maps it to a User
  Stream<AuthUser> get currUserModel {
    return _auth.onAuthStateChanged.map(_createUserModel);
  }

  // sign in with email and pw
  Future<AuthUser> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      AuthResult authRes = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = authRes.user;
      return _createUserModel(user);
    } catch (err) {
      throw err;
    }
  }

  // register with email and pw
  Future<AuthUser> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      AuthResult authRes = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = authRes.user;
      return _createUserModel(user);
    } catch (err) {
      print(err);
      throw err;
    }
  }

  // sign out
  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

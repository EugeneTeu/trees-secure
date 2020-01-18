import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tree_secure/services/firestore_service.dart';

class SplashScreen extends StatelessWidget {
  final bool isDataDocEmpty;

  SplashScreen({@required this.isDataDocEmpty});

  @override
  Widget build(BuildContext context) {
    if (this.isDataDocEmpty) {
      FirestoreService fs = FirestoreService.instance;
      fs.createUserDoc();
    }

    return Container(
      color: Colors.green[800],
      child: Center(
        child: SpinKitRipple(
          color: Colors.teal[200],
          size: 150,
        ),
      ),
    );
  }
}
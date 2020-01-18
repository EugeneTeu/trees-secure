import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[800],
      child: Center(
        child: SpinKitRipple(
          color: Colors.teal[200],
          size: 150,
        ),
      ),
    );
  }
}

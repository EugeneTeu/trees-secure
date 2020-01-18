import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class TreeSecureLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 400,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          /*
          RotatedBox(
            child: Icon(
              LineIcons.dollar,
              size: 200,
            ),
            quarterTurns: 3,
          ),
          RotatedBox(
            child: Icon(
              LineIcons.dollar,
              size: 200,
            ),
            quarterTurns: 6,
          ),*/
          Positioned(
              top: 300,
              left: 30,
              child: Text(
                "Tree-Secure",
                style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
              )),
          Center(
            child: Icon(
              LineIcons.tree,
              size: 200,
            ),
          ),
          Positioned(
            top: 130,
            left: 190,
            child: Icon(
              LineIcons.tree,
              size: 200,
            ),
          ),
          Positioned(
            top: 130,
            right: 190,
            child: Icon(
              LineIcons.tree,
              size: 200,
            ),
          )
        ],
      ),
    );
  }
}

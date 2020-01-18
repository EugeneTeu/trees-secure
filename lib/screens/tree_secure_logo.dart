import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class TreeSecureLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width / 3 * 2,
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
              top: 280,
              left: 40,
              child: Text(
                "Tree-Secure",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              )),
          Center(
            child: Icon(
              LineIcons.tree,
              size: 150,
            ),
          ),
          Positioned(
            top: 130,
            left: 150,
            child: Icon(
              LineIcons.tree,
              size: 150,
            ),
          ),
          Positioned(
            top: 130,
            right: 150,
            child: Icon(
              LineIcons.tree,
              size: 150,
            ),
          )
        ],
      ),
    );
  }
}

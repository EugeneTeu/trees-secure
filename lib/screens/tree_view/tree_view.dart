import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tree_secure/models/tree.dart';

class TreeView extends StatefulWidget {
  TreeView(this.tree);

  final Tree tree;
  @override
  _TreeViewState createState() => _TreeViewState();
}

class _TreeViewState extends State<TreeView> {
  Tree tree;

  @override
  void initState() {
    super.initState();
    this.tree = widget.tree;
  }

  @override
  Widget build(BuildContext context) {
    var r = Random();
    var fgColor = Color(0xfff2f2f2);
    double lineHeight = 16;
    return Container(
      height: MediaQuery.of(context).size.height / 3 * 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1.0),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(26),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: fgColor),
            height: 50,
            width: 50,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 10 * 5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: fgColor),
            child: ListView(
              physics: AlwaysScrollableScrollPhysics(),
              children: <Widget>[
                ListTile(
                  title: Text(tree.scientificName),
                  subtitle: Text("Scientific name"),
                ),
                ListTile(
                  title: Text(tree.commonName),
                  subtitle: Text("Common name"),
                ),
                ListTile(
                  title: Text(tree.description),
                  subtitle: Text("Description"),
                ),
                ListTile(
                  title: Text(tree.girth),
                  subtitle: Text("Girth"),
                ),
                ListTile(
                  title: Text(tree.height),
                  subtitle: Text("Height"),
                ),
                ListTile(
                  title: Text(tree.location),
                  subtitle: Text("location"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

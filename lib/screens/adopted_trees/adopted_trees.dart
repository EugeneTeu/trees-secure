import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tree_secure/models/tree.dart';
import 'package:tree_secure/models/user.dart';
import 'package:tree_secure/shared/loading_spinner.dart';

class AdoptedTrees extends StatefulWidget {
  @override
  _AdoptedTreesState createState() => _AdoptedTreesState();
}

class _AdoptedTreesState extends State<AdoptedTrees>
    with AutomaticKeepAliveClientMixin {
  final List<Widget> listOfAdoptedTrees = [];
  final List<Tree> listOfTree = [];
  bool isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    //load from provider here
    loadTreeFromJson().then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  loadTreeFromJson() async {
    String data = await rootBundle.loadString("assets/formatted_trees.json");
    Map<String, dynamic> jsonResult = json.decode(data);
    jsonResult.forEach((String key, dynamic object) {
      Tree temp = Tree();
      temp.commonName = object['Common name'];
      temp.id = key;
      listOfTree.add(temp);
    });

    listOfTree.forEach((tree) {
      var temp = ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          title: Text("Tree ID: ${tree.id}"),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: BoxDecoration(
                border:
                    Border(right: BorderSide(width: 1.0, color: Colors.black))),
            child: Icon(Icons.dashboard, color: Colors.black),
          ),
          subtitle: Row(
            children: <Widget>[
              Icon(Icons.terrain, color: Theme.of(context).primaryColorDark),
              Text(" TREEE", style: TextStyle(color: Colors.black))
            ],
          ),
          trailing: Icon(Icons.keyboard_arrow_right,
              color: Colors.black, size: 30.0));
      listOfAdoptedTrees.add(temp);
    });
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);

    super.build(context);
    return isLoading
        ? LoadingSpinner()
        : Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 8.0),
                Row(),
                ListTile(
                  enabled: true,
                  title: Text("Number of Trees Visited:"),
                  trailing: Text('${user.visitedTrees.length}'),
                ),
                ListTile(
                  enabled: true,
                  title: Text("Number of Trees Adopted:"),
                  trailing: Text('${user.adoptedTrees.length}'),
                ),
                Text("These are your adopted Trees"),
                SizedBox(height: 8.0),
                Container(
                  height: MediaQuery.of(context).size.height / 3 * 2,
                  child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    cacheExtent: 20.0,
                    shrinkWrap: true,
                    itemCount: 255,
                    itemBuilder: (BuildContext context, int index) {
                      return listOfAdoptedTrees[index];
                    },
                  ),
                )
              ],
            ),
          );
  }

  @override
  bool get wantKeepAlive => true;
}

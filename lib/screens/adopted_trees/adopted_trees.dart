import 'package:flutter/material.dart';

import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:tree_secure/models/static_data.dart';
import 'package:tree_secure/models/tree.dart';
import 'package:tree_secure/models/user.dart';
import 'package:tree_secure/screens/tree_view/tree_view.dart';
import 'package:tree_secure/shared/loading_spinner.dart';

class AdoptedTrees extends StatefulWidget {
  @override
  _AdoptedTreesState createState() => _AdoptedTreesState();
}

class _AdoptedTreesState extends State<AdoptedTrees>
    with AutomaticKeepAliveClientMixin {
  final List<Widget> listOfAdoptedTrees = [];
  List<String> listOfUserAdapted = [];
  List<Tree> listOfTree = [];
  Map<String, Tree> mapOfTrees = Map();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  void _showTreeDialog(BuildContext context, Tree tree) {
    showDialog(
      context: context,
      builder: (_) {
        return Theme(
          data: Theme.of(context),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            elevation: 0.0,
            child: TreeView(tree, false),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final StaticData data = Provider.of<StaticData>(context);
    final User user = Provider.of<User>(context);

    listOfUserAdapted = user.adoptedTrees;
    mapOfTrees = data.mapOfTree;

    return Card(
      elevation: 32.0,
      child: isLoading
          ? LoadingSpinner()
          : Container(
              height: MediaQuery.of(context).size.height - 32.0,
              child: listOfTree.length == 0
                  ? Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          LineIcons.bitcoin,
                          size: 300,
                        ),
                        Text(
                          "You have not adopted any trees!",
                          style: TextStyle(fontSize: 24.0),
                        ),
                        Text("Head over to Discover trees!",
                            style: TextStyle(fontSize: 24.0))
                      ],
                    ))
                  : ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      cacheExtent: 20.0,
                      shrinkWrap: true,
                      itemCount: listOfUserAdapted.length,
                      itemBuilder: (BuildContext context, int index) {
                        String key = listOfUserAdapted[index];
                        Tree tempTree = mapOfTrees[key];

                        return ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            title: Text("Tree: ${tempTree.commonName}"),
                            leading: Container(
                              padding: EdgeInsets.only(right: 12.0),
                              decoration: BoxDecoration(
                                  border:
                                      Border(right: BorderSide(width: 1.0))),
                              child: Icon(
                                LineIcons.tree,
                                size: 50,
                              ),
                            ),
                            subtitle: Row(
                              children: <Widget>[
                                Icon(Icons.terrain,
                                    color: Theme.of(context).primaryColorDark),
                                Text(" ${tempTree.id}", style: TextStyle())
                              ],
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                _showTreeDialog(context, tempTree);
                              },
                              icon:
                                  Icon(Icons.keyboard_arrow_right, size: 30.0),
                            ));
                      },
                    ),
            ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:tree_secure/models/static_data.dart';
import 'package:tree_secure/models/tree.dart';
import 'package:tree_secure/models/user.dart';
import 'package:tree_secure/models/user_list.dart';
import 'package:tree_secure/screens/stripe_pay/webview_stripe.dart';
import 'package:tree_secure/screens/tree_view/tree_view.dart';
import 'package:tree_secure/shared/loading_spinner.dart';

class VisitedTrees extends StatefulWidget {
  @override
  _VisitedTreesState createState() => _VisitedTreesState();
}

class _VisitedTreesState extends State<VisitedTrees>
    with AutomaticKeepAliveClientMixin {
  final List<Widget> listOfVisitedTrees = [];
  List<Tree> listOfTree = [];
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
    final UserList userLst = Provider.of<UserList>(context);

    listOfTree = userLst.listOfVisitedTree;

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
                          LineIcons.wheelchair,
                          size: 300.0,
                        ),
                        Text(
                          "You have not visited any trees!",
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
                      itemCount: listOfTree.length,
                      itemBuilder: (BuildContext context, int index) {
                        Tree tempTree = listOfTree[index];

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
                                Icons.dashboard,
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

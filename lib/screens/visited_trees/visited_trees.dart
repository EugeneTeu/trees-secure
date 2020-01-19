import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:tree_secure/models/static_data.dart';
import 'package:tree_secure/models/tree.dart';
import 'package:tree_secure/models/user.dart';
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

  bool isLoading = false;
  List<String> listOfUserVisited = [];
  Map<String, Tree> mapOfTrees = Map();

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
            child: TreeView(tree, false, null, null, null),
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

    listOfUserVisited = user.visitedTrees;
    mapOfTrees = data.mapOfTree;

    print(listOfUserVisited);

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        elevation: 5.0,
        child: Container(
          child: listOfUserVisited.length == 0
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
                  itemCount: listOfUserVisited.length,
                  itemBuilder: (BuildContext context, int index) {
                    String key = listOfUserVisited[index];
                    Tree tempTree = mapOfTrees[key];

                    return ListTile(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 10.0,
                        ),
                        title: Text("${tempTree.commonName}"),
                        leading: Container(
                          padding: EdgeInsets.only(right: 12.0),
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                  width: 1.0,
                                  color: Theme.of(context).accentColor),
                            ),
                          ),
                          child: Image.network(
                            tempTree.image,
                            width: 70,
                            height: 70,
                          ),
                        ),
                        subtitle: Text("ID: ${tempTree.id}"),
                        trailing: IconButton(
                          onPressed: () {
                            _showTreeDialog(context, tempTree);
                          },
                          icon: Icon(Icons.keyboard_arrow_right, size: 30.0),
                        ));
                  },
                ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

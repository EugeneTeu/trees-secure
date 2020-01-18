import 'package:flutter/material.dart';

class AdoptedTrees extends StatefulWidget {
  @override
  _AdoptedTreesState createState() => _AdoptedTreesState();
}

class _AdoptedTreesState extends State<AdoptedTrees>
    with AutomaticKeepAliveClientMixin {
  final List<Widget> listOfAdoptedTrees = [Text("dadas")];

  @override
  void initState() {
    super.initState();
    //load from provider here
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 8.0),
          ListTile(
            enabled: false,
            title: Text("Number of Trees"),
            subtitle: Text("num of trees here"),
          ),
          Text("These are your adopted Trees"),
          SizedBox(height: 8.0),
          Container(
            width: 200,
            height: MediaQuery.of(context).size.height / 2,
            child: SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return listOfAdoptedTrees[index];
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

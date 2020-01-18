import 'package:flutter/material.dart';

class VisitedTrees extends StatefulWidget {
  @override
  _VisitedTreesState createState() => _VisitedTreesState();
}

class _VisitedTreesState extends State<VisitedTrees>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: Text("Visited treees"),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

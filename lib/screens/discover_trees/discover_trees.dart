import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class DiscoverTrees extends StatefulWidget {
  @override
  _DiscoverTreesState createState() => _DiscoverTreesState();
}

class _DiscoverTreesState extends State<DiscoverTrees>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("DISCOVER TREES"),
          Text("This Feature is underway")
        ],
      )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

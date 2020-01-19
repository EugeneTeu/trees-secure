import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';

import 'package:tree_secure/models/tree.dart';
import 'package:tree_secure/screens/stripe_pay/webview_stripe.dart';
import 'package:tree_secure/services/firestore_service.dart';

import 'package:tree_secure/models/user.dart';

class TreeView extends StatefulWidget {
  TreeView(this.tree, this.fromDiscoverScreen, this.currPosition,
      this._scaffoldKey, this.user);

  final Tree tree;
  final bool fromDiscoverScreen;
  final Position currPosition;
  final GlobalKey<ScaffoldState> _scaffoldKey;
  final User user;

  @override
  _TreeViewState createState() => _TreeViewState();
}

class _TreeViewState extends State<TreeView> {
  final FirestoreService fs = FirestoreService.instance;

  Future<Position> getLocation() {
    return Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  }

  bool isAlreadyVisited() {
    return widget.user.visitedTrees.contains(widget.tree.id);
  }

  bool isAlreadyAdopted() {
    return widget.user.adoptedTrees.contains(widget.tree.id);
  }

  bool withinRange() {
    if (widget.currPosition == null) return false;
    List coor = jsonDecode(this.widget.tree.coordinates);
    double lat = coor[0];
    double long = coor[1];
    double userLat = widget.currPosition.latitude;
    double userLong = widget.currPosition.longitude;
    Distance distance = Distance();
    double km = distance.as(
        LengthUnit.Kilometer, LatLng(userLat, userLong), LatLng(lat, long));
    return km < 0.5;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3 * 2,
      child: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            ...(widget.tree.image == null
                ? []
                : [Image.network(widget.tree.image)]),
            ListTile(
              title: Text(widget.tree.scientificName),
              subtitle: Text("Scientific Name"),
            ),
            ListTile(
              title: Text(widget.tree.commonName),
              subtitle: Text("Common Name"),
            ),
            ListTile(
              title: Text(widget.tree.description),
              subtitle: Text("Description"),
            ),
            ListTile(
              title: Text(widget.tree.girth),
              subtitle: Text("Girth (m)"),
            ),
            ListTile(
              title: Text(widget.tree.height),
              subtitle: Text("Height (m)"),
            ),
            ListTile(
              title: Text(widget.tree.location),
              subtitle: Text("Location Description"),
            ),
            widget.fromDiscoverScreen
                ? ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.blueAccent,
                        child: isAlreadyVisited()
                            ? Text('ALREADY VISITED')
                            : !withinRange()
                                ? Text('TOO FAR TO VISIT')
                                : Text('VISIT'),
                        onPressed: !withinRange() || isAlreadyVisited()
                            ? null
                            : () {
                                this.fs.visitTree(widget.tree.id);
                                Navigator.of(context).pop();
                                widget._scaffoldKey.currentState.showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.green,
                                    content:
                                        Text('Successfully visited this tree!'),
                                  ),
                                );
                              },
                      ),
                      Divider(),
                      RaisedButton(
                        color: Colors.green,
                        child: isAlreadyAdopted() ? Text('ALREADY ADOPTED') : Text('ADOPT'),
                        onPressed: isAlreadyAdopted()
                            ? null
                            : () {
                                Navigator.of(context).pop();
                                showDialog(
                                  context: context,
                                  builder: (_) => WebviewStripe(),
                                );
                                //this.fs.adoptTree(tree.id);
                                //Navigator.of(context).pop();
                              },
                      ),
                    ],
                  )
                : SizedBox.shrink()
          ],
        ).toList(),
      ),
    );
  }
}

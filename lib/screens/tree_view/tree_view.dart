import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:tree_secure/models/tree.dart';
import 'package:tree_secure/screens/stripe_pay/webview_stripe.dart';
import 'package:tree_secure/services/firestore_service.dart';

class TreeView extends StatelessWidget {
  TreeView(this.tree, this.fromDiscoverScreen);

  final Tree tree;
  final bool fromDiscoverScreen;
  final FirestoreService fs = FirestoreService.instance;

  Future<Position> getLocation() {
    return Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  }

  Future<bool> withinRange(double latitude, double longitude) {
    return getLocation()
    .then((Position position) {
      double userLat = position.latitude;
      double userLong = position.longitude;
      Distance distance = new Distance();
      double km = distance.as(LengthUnit.Kilometer, new LatLng(userLat, userLong), new LatLng(latitude, longitude));
      print('Distance: $km');
      return km < 0.5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3 * 2,
      child: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            ...(tree.image == null ? [] : [Image.network(tree.image)]),
            ListTile(
              title: Text(tree.scientificName),
              subtitle: Text("Scientific Name"),
            ),
            ListTile(
              title: Text(tree.commonName),
              subtitle: Text("Common Name"),
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
              subtitle: Text("Location Description"),
            ),
            fromDiscoverScreen
                ? ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.blueAccent,
                        child: Text("Visit"),
                        onPressed: () async {
                          List coor = jsonDecode(this.tree.coordinates);
                          double lat = coor[0];
                          double long = coor[1];
                          if (await withinRange(lat, long)) {
                            print('Within range.');
                            this.fs.visitTree(tree.id);
                            Navigator.of(context).pop();
                          } else {
                            print('Out of range.');
                          }
                        },
                      ),
                      Divider(),
                      RaisedButton(
                        color: Colors.green,
                        child: Text("Adopt"),
                        onPressed: () {
                          Navigator.of(context).pop();
                          showDialog(
                              context: context,
                              builder: (_) => WebviewStripe());

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

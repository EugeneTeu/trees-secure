import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import 'package:tree_secure/models/tree.dart';
import 'package:tree_secure/models/user.dart';
import 'package:tree_secure/services/firestore_service.dart';

class TreeView extends StatelessWidget {
  TreeView(this.tree, this.fromDiscoverScreen);

  final Tree tree;
  final bool fromDiscoverScreen;
  final FirestoreService fs = FirestoreService.instance;

  Future<Position> getLocation() {
    return Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  }

  bool withinRange(String centre) {
    getLocation()
    .then((Position position) {
      print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
      print('Centre: $centre');
      return true;
    })
    .catchError((error) {
      print(error.toString());
      return false;
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
                        onPressed: () {
                          if (withinRange(this.tree.location)) {
                            print('Within range.');
                          }
                          this.fs.visitTree(tree.id);
                        },
                      ),
                      Divider(),
                      RaisedButton(
                        color: Colors.green,
                        child: Text("Adopt"),
                        onPressed: () {
                          this.fs.adoptTree(tree.id);
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

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'package:tree_secure/models/user.dart';
import 'package:tree_secure/models/static_data.dart';
import 'package:tree_secure/models/tree.dart';
import 'package:tree_secure/screens/tree_view/tree_view.dart';

class DiscoverTreesMap extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey;

  DiscoverTreesMap(this._scaffoldKey);

  @override
  _DiscoverTreesMapState createState() => _DiscoverTreesMapState();
}

class _DiscoverTreesMapState extends State<DiscoverTreesMap> {
  String _mapDarkTheme;
  String _mapLightTheme;
  StreamSubscription<Position> positionStream;
  Position currPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rootBundle.loadString('assets/map_dark_theme.json').then((string) {
      _mapDarkTheme = string;
    });
    rootBundle.loadString('assets/map_light_theme.json').then((string) {
      _mapLightTheme = string;
    });
    positionStream =
        Geolocator().getPositionStream().listen((Position position) {
      setState(() {
        currPosition = position;
      });
    });
  }

  @override
  void dispose() {
    positionStream.cancel();
    super.dispose();
  }

  Set<Marker> _buildMarkers(Map<String, Tree> treeData, BuildContext context, User user) {
    Set<Marker> markers = Set<Marker>();

    treeData.forEach((String id, Tree tree) {
      List coordinates = jsonDecode(tree.coordinates);
      markers.add(
        Marker(
          markerId: MarkerId(id),
          position: LatLng(coordinates[0], coordinates[1]),
          infoWindow: InfoWindow(
            title: tree.commonName,
            snippet: 'Tap for more information',
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext _) {
                  return Theme(
                    data: Theme.of(context),
                    child: Dialog(
                      child: TreeView(
                        tree,
                        true,
                        currPosition,
                        widget._scaffoldKey,
                        user
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      );
    });
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    final Map<String, Tree> treeData =
        Provider.of<StaticData>(context).mapOfTree;

    return Container(
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: const LatLng(1.3521, 103.8198),
          zoom: 11,
        ),
        myLocationEnabled: true,
        onMapCreated: (GoogleMapController ctrl) {
          if (_mapDarkTheme == null || _mapLightTheme == null) {
            return;
          }
          if (user.isDarkTheme) {
            ctrl.setMapStyle(_mapDarkTheme);
          } else {
            ctrl.setMapStyle(_mapLightTheme);
          }
        },
        markers: _buildMarkers(treeData, context, user),
      ),
    );
  }
}

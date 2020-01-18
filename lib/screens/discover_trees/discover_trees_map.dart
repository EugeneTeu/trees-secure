import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'package:tree_secure/models/user.dart';
import 'package:tree_secure/models/static_data.dart';
import 'package:tree_secure/models/tree.dart';

class DiscoverTreesMap extends StatefulWidget {
  @override
  _DiscoverTreesMapState createState() => _DiscoverTreesMapState();
}

class _DiscoverTreesMapState extends State<DiscoverTreesMap> {
  String _mapDarkTheme;
  String _mapLightTheme;

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
  }

  Set<Marker> _buildMarkers(Map<String, Tree> treeData, BuildContext context) {
    Set<Marker> markers = Set<Marker>();

    treeData.forEach((String id, Tree tree) {
      List coordinates = jsonDecode(tree.coordinates);
      markers.add(
        Marker(
          markerId: MarkerId(id),
          position: LatLng(coordinates[0], coordinates[1]),
          infoWindow: InfoWindow(
            title: tree.commonName,
            // snippet: tree.description,
          ),
          onTap: () {
            // Scaffold.of(context).showBottomSheet((context) {
            //   return Container(
            //     height: 250,
            //     width: double.infinity,
            //     child: Center(
            //       child: Text(tree.id),
            //     ),
            //   );
            // });
          },
        ),
      );
    });
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    final Map<String, Tree> treeData =
        Provider.of<StaticData>(context, listen: false).mapOfTree;

    return Container(
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: const LatLng(1.3521, 103.8198),
          zoom: 11,
        ),
        myLocationEnabled: true,
        onMapCreated: (GoogleMapController ctrl) {
          if (user.isDarkTheme) {
            ctrl.setMapStyle(_mapDarkTheme);
          } else {
            ctrl.setMapStyle(_mapLightTheme);
          }
        },
        markers: _buildMarkers(treeData, context),
      ),
    );
  }
}

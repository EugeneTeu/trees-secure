import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';

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

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);

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
      ),
    );
  }
}

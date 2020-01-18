import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DiscoverTreesMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: const LatLng(1.3521, 103.8198),
          zoom: 11,
        ),
        myLocationEnabled: true,
      ),
    );
  }
}

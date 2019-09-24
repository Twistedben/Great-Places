import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // Comes from pubspec.yml google_maps_flutter dependency. ALlows GoogleMap()

import '../models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation; // Instantiated in place.dart as a type
  final bool isSelecting;

  // Initializes it, both values are defaulted
  MapScreen(
      {this.initialLocation =
          const PlaceLocation(latitude: 37.4220, longitude: -122.0840),
      this.isSelecting = false});

  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Map'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 16,
        ),
      ),
    );
  }
}

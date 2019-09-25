import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // Comes from pubspec.yml google_maps_flutter dependency. ALlows GoogleMap()

import '../models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation; // Instantiated in place.dart as a type
  final bool isSelecting;

  // Initializes it, both values are defaulted
  MapScreen({
    this.initialLocation =
        const PlaceLocation(latitude: 37.4220, longitude: -122.0840),
    this.isSelecting = false,
  });

  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Map'),
        actions: <Widget>[
          if (widget.isSelecting)
            IconButton(
              icon: Icon(Icons.check),
              // If there is no picked location, onPressed is set to null so the button is disabled, otherwise is enabled and will navigate back with _pickedLocation
              onPressed: _pickedLocation == null
                  ? null
                  : () {
                      // We pop the screen and pass the picked location to the location_input.dart Future _selectOnMap()
                      Navigator.of(context).pop(_pickedLocation);
                    },
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 16,
        ),
        // Allows ontap actions, calls above method to set LatLgn location
        onTap: widget.isSelecting ? _selectLocation : null,
        // If we have a picked location due to ontop, render a marker (this is a Set data type, which is like a list with only values {}, each value needs to be unique in a set) for it otherwise null/
        markers: _pickedLocation == null
            ? null
            : {
                Marker(markerId: MarkerId('m1'), position: _pickedLocation),
              },
      ),
    );
  }
}

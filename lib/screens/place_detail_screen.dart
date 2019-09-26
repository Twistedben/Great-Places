import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/map_screen.dart';
import '../providers/great_places.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/place-detail';

  @override
  Widget build(BuildContext context) {
    // Retreives the ID from the route
    final id = ModalRoute.of(context).settings.arguments;
    // Calls great_places findById method to return a single instance of a great place.
    final selectedPlace =
        Provider.of<GreatPlaces>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(title: Text(selectedPlace.title)),
      body: Column(
        children: <Widget>[
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(height: 10),
          Text(
            selectedPlace.location.address,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          SizedBox(height: 10),
          FlatButton(
            child: Text('View on Map'),
            textColor: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (ctx) => MapScreen(
                    initialLocation: selectedPlace.location,
                    isSelecting: false, //defualt so optional
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

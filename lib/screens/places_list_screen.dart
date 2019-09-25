import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';
import '../providers/great_places.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Places'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
            ),
          ],
        ),
        body: FutureBuilder(
          // Calls setPLaces from great_places.dart with a futurebuilder and checks if it's waiting to show a progress indicator, otherwise render the Consumer data
          future: Provider.of<GreatPlaces>(context, listen: false).setPlaces(),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              // childText will be displayed and not updated, referring to what was set as child: in the consumer. So in this case, the Centered text saying 'no places...' will be shown if the ternary of checking greatplaces being empty is trye
              : Consumer<GreatPlaces>(
                  child: Center(
                    child: const Text('No places added yet. Start adding now!'),
                  ),
                  builder: (ctx, greatPlaces, childText) =>
                      greatPlaces.items.length <= 0
                          ? childText
                          : ListView.builder(
                              itemCount: greatPlaces.items.length,
                              itemBuilder: (ctx, index) => ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      FileImage(greatPlaces.items[index].image),
                                ),
                                title: Text(greatPlaces.items[index].title),
                                subtitle: Text(
                                    greatPlaces.items[index].location.address),
                                onTap: () {
                                  // Go to detail page..
                                },
                              ),
                            ),
                ),
        ));
  }
}

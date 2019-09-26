import 'dart:io';
import 'package:flutter/foundation.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';
import '../helpers/location_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  // Creates a copy of items.
  List<Place> get items {
    return [..._items];
  }

  // Used in place_detail_screen to find a single id instance of a great place
  Place findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }

  // Method for adding and storing a place from add_place_screen form
  Future<void> addPlace(String pickedTitle, File pickedImage,
      PlaceLocation pickedLocation) async {
    // We want to turn pickedLocation into a human readble address
    final address = await LocationHelper.getPlaceAddress(
        pickedLocation.latitude, pickedLocation.longitude);
    final updatedLocation = PlaceLocation(
        latitude: pickedLocation.latitude,
        longitude: pickedLocation.longitude,
        address: address);
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: updatedLocation,
    );
    _items.add(newPlace);
    notifyListeners();
    // Calls the insert helper method from db_helper in our helpers folder to insert data into the SQLite DB
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address,
    });
  }

  // A method for fetching data, defined in db_helper.dart
  Future<void> setPlaces() async {
    // Call getData from db_helper and pass in the name of the table which is 'places' as defined above in addplace.
    final dataList = await DBHelper.getData('user_places');
    // Transform the dataList to a list of places. This is calling the data from above in insert.
    _items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: PlaceLocation(
              latitude: item['loc_lat'],
              longitude: item['loc_lng'],
              address: item['address'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}

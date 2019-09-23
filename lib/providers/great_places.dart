import 'dart:io';
import 'package:flutter/foundation.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  // Creates a copy of items.
  List<Place> get items {
    return [..._items];
  }

  // Method for adding and storing a place from add_place_screen form
  void addPlace(String pickedTitle, File pickedImage) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: null,
    );
    _items.add(newPlace);
    notifyListeners();
    // Calls the insert helper method from db_helper in our helpers folder to insert data into the SQLite DB
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path
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
            location: null,
          ),
        )
        .toList();
    notifyListeners();
  }
}

import 'package:flutter/foundation.dart';

import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  // Creates a copy of items.
  List<Place> get items {
    return [..._items];
  }
}

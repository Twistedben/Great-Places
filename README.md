# Great Places - Photo App

A Mobile Dart/Flutter App that allows you to use your camera to take a picture of where you are and attach a GPS location to it, which will then provide you with an address as well. Store all your favorite places and exactly where you took that picture!

## Tech/Features

- Local storage usage for in-app photos using Paths, Path_Provider, and Sqflite.
- Attached SQLite Database for iOS and Android compatibility for local device storage.
- Uses Native Camera feature to snap photos.
- Uses Google Maps for current location (Native GPS) and latitude/longitude of where the picture was taken.
- Accesses GoogleMaps for interactive mapping and marker pinning.
- Reverse geocoding used to provide address of where the photo was taken or where the marker was added.

### Description

This app was built mainly to demonstrate the use of native device features, such as Camera and GPS, as well as the use of Google Maps API. It also uses a SQLite 3 DB for local storage of the pictures and relevant data taken.

### Screenshots

![alt text](https://github.com/Twistedben/Great-Places/blob/master/screenshots/great_places_list.png "List of places and photos")
![alt text](https://github.com/Twistedben/Great-Places/blob/master/screenshots/great_places_form.png "New Place form with location, maps and camera")
![alt text](https://github.com/Twistedben/Great-Places/blob/master/screenshots/great_places_map.png "Google Maps and Marker")
![alt text](https://github.com/Twistedben/Great-Places/blob/master/screenshots/great_places_show.png "Individual Place")

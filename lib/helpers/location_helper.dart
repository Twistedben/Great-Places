// Used in the location_input.dart file for location preview and current location.
const GOOGLE_API_KEY = 'AIzaSyDH-_uP6ghQkCRQKsDfMTbS_94_BJlMkDs';

class LocationHelper {
  static String generateLocationPreviewImage(
      {double latitude, double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }
}

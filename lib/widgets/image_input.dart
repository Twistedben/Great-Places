import 'dart:io';

import 'package:flutter/material.dart';
// Allows images to be taken from app.
import 'package:image_picker/image_picker.dart';
// Path package to merge file system paths.
import 'package:path/path.dart' as path;
// Path_Provider package for finding paths in local file system.
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  // Comes from add_place_screen, passed in by ImageInput(). Used below in _takePicture()
  final Function onSelectImage;

  ImageInput(this.onSelectImage);

  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  // We use File type here from imported dart:io
  File _storedImage;

  // Below - Using image_picker. Needs to be added to pubspec.yaml and imported above
  Future<void> _takePicture() async {
    // Opens camera and takes picture, returns a future so async await is needed
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource
          .camera, // Source of where the image comes from, camera here not gallery
      maxWidth: 600, // Restricts resolution
    );
    setState(() {
      // Allows the image preview below
      _storedImage = imageFile;
    });
    // PRevents error in canceling picture, breaking out since the imageFile would be null
    if (imageFile == null) {
      return;
    }
    // Begin - Write the image to local file system using above imported packages: path as path and path_provider as syspaths.
    final appDir = await syspaths
        .getApplicationDocumentsDirectory(); // Location for app data, gives a future
    final fileName = path.basename(imageFile
        .path); // basename is the name of the file name and ext and imageFile.path is the path to where the imageFile is temporarily stored
    final savedImage = await imageFile.copy(
        '${appDir.path}/$fileName'); // Returns a future and Copies the file into the path and keeps the file name. Writes the image to the path found by appDir above using getApplicationDocumentsDirectory()
    // End - Image Write
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 165,
          height: 125,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          // Image.file allows the use of a locally stored image file to be rendered
          child: _storedImage != null
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  'No Image Attached',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(width: 10),
        Expanded(
          child: FlatButton.icon(
            icon: Icon(Icons.camera_alt),
            label: Text('Take Picture'),
            textColor: Theme.of(context).primaryColor,
            onPressed: _takePicture,
          ),
        ),
      ],
    );
  }
}

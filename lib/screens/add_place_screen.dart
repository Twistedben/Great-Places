import 'package:flutter/material.dart';

import '../widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a new Place"),
      ),
      body: Column(
        // Stretches the children across the screen to take full width horizontally.
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Takes all the available space
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    // Since no parent Form() we use TextField() instead of TextFormField(), and have to manually wire it up
                    TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                    ),
                    SizedBox(height: 10),
                    ImageInput(),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            // Removes drop shadow
            elevation: 0,
            // Modifies the space around an element for tapping on it. ShrinkWrap decreases this margin size
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
            icon: Icon(Icons.add),
            label: Text('Add Place'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
